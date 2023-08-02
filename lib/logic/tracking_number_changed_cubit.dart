import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingNumberChanged extends Cubit<String> {
  TrackingNumberChanged() : super('');

  void updateTrackingNumber(String value) => emit(value);
}
