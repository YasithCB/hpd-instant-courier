import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_app/data/models/rider_model.dart';
import 'package:courier_app/data/repositories/driver_repo.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverBloc() : super(DriverInitial());
  final DriverRepo _driverRepo = DriverRepo();

  @override
  DriverState get initialState => DriverInitial();

  @override
  Stream<DriverState> mapEventToState(DriverEvent event) async* {
    if (event is FetchDrivers) {
      try {
        // Fetch the drivers from Firestore
        final driverSnapshots = await _driverRepo.getAllDrivers();

        // Convert DocumentSnapshots to Driver objects
        final drivers = driverSnapshots.map((snapshot) {
          final data = snapshot.data() as Map<String, dynamic>;
          return Driver.fromMap(snapshot.id, data);
        }).toList();

        yield DriverLoaded(
            drivers); // Emit DriverLoaded state with the list of drivers
      } catch (e) {
        yield DriverError(e.toString());
      }
    }
  }
}

// Events
abstract class DriverEvent {}

class FetchDrivers extends DriverEvent {
  final GeoPoint clientLocation;

  FetchDrivers(this.clientLocation);
}

// States
abstract class DriverState {}

class DriverInitial extends DriverState {}

class DriverLoaded extends DriverState {
  final List<Driver> driver;
  DriverLoaded(this.driver);
}

class DriverError extends DriverState {
  final String error;

  DriverError(this.error);
}
