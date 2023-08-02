import 'dart:async';

import 'package:courier_app/presentation/screens/confirm_pickup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class SendparcelScreen extends StatefulWidget {
  const SendparcelScreen({Key? key}) : super(key: key);

  @override
  State<SendparcelScreen> createState() => _SendparcelScreenState();
}

class _SendparcelScreenState extends State<SendparcelScreen> {
  final CameraPosition slCameraPosition = const CameraPosition(
    target: LatLng(7.8731, 80.7718),
    zoom: 8.0,
  );
  final Completer<GoogleMapController> completer = Completer();
  LatLng? tappedLocation;
  String address = '';

  Future<void> onMapTapped(LatLng location) async {
    setState(() {
      tappedLocation = location;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          address = placemarks[0].name ?? '';
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while fetching address: $e');
      }
    }
  }

  void onConfirmLocation() {
    if (tappedLocation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPickupScreen(location: tappedLocation!, address: address),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a location on the map.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Location",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        onTap: onMapTapped,
        mapType: MapType.normal,
        initialCameraPosition: slCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          completer.complete(controller);
        },
        markers: tappedLocation != null
            ? {
                Marker(
                  markerId: MarkerId(address),
                  position: tappedLocation!,
                  infoWindow: InfoWindow(title: address),
                ),
              }
            : {},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onConfirmLocation,
        label: const Text(
          'Confirm Pickup Location',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
