import 'dart:async';
import 'dart:convert';

import 'package:courier_app/logic/util.dart';
import 'package:courier_app/presentation/screens/confirm_pickup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class SendParcelScreen extends StatefulWidget {
  const SendParcelScreen({Key? key}) : super(key: key);

  @override
  State<SendParcelScreen> createState() => _SendParcelScreenState();
}

class _SendParcelScreenState extends State<SendParcelScreen> {
  // final CameraPosition slCameraPosition = const CameraPosition(
  //   target: LatLng(7.8731, 80.7718),
  //   zoom: 8.0,
  // );
  final CameraPosition romaniaCameraPosition = const CameraPosition(
    target: LatLng(45.9432, 24.9668), // Center of Romania
    zoom: 6.0, // Zoom level
  );

  final Completer<GoogleMapController> completer = Completer();

  bool isPickupLocationConfirmed = false;
  LatLng? pickLocation;
  LatLng? dropLocation;
  String pickAddress = '';
  String dropAddress = '';

  Future<void> onMapTapped(LatLng location) async {
    setState(() {
      isPickupLocationConfirmed
          ? dropLocation = location
          : pickLocation = location;
    });

    const apiKey = 'AIzaSyALbAWpvL0yK2jmxlTezNvf10bnQmhOdVQ';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['status'] == 'OK') {
          final results = decoded['results'][0];
          final formattedAddress = results['formatted_address'];
          setState(() {
            isPickupLocationConfirmed
                ? dropAddress = formattedAddress
                : pickAddress = formattedAddress;
          });
        }
      } else {
        print('API request failed with status ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching address: $e');
    }
  }

  void onConfirmLocation() {
    if (pickLocation != null && dropLocation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPickupScreen(
            pickLocation: pickLocation!,
            pickAddress: pickAddress,
            dropAddress: dropAddress,
            dropLocation: dropLocation!,
          ),
        ),
      );
    } else if (pickLocation != null) {
      showSnackBar(context,
          'Pickup location confirmed! Please choose destination to proceed');
      setState(() {
        isPickupLocationConfirmed = true;
      });
    } else {
      removeCurrentSnackbars(context);
      showSnackBar(context, 'Please select a location on the map.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isPickupLocationConfirmed
              ? "Choose Destination Location"
              : "Choose Pickup Location",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        onTap: onMapTapped,
        mapType: MapType.normal,
        initialCameraPosition: romaniaCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          completer.complete(controller);
        },
        markers: isPickupLocationConfirmed
            ? dropLocation != null
                ? {
                    Marker(
                      markerId: MarkerId(dropAddress),
                      position: dropLocation!,
                      infoWindow: InfoWindow(
                          title: dropAddress,
                          snippet: 'This is the your parrcel\'s destination'),
                    ),
                  }
                : {}
            : pickLocation != null
                ? {
                    Marker(
                      markerId: MarkerId(pickAddress),
                      position: pickLocation!,
                      infoWindow: InfoWindow(
                          title: pickAddress,
                          snippet: 'You can handover your parcel from here'),
                    ),
                  }
                : {},
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              onConfirmLocation();
            },
            label: Text(
              isPickupLocationConfirmed
                  ? 'Confirm Destination Location'
                  : 'Confirm Pickup Location',
              style: const TextStyle(color: Colors.white),
            ),
            icon: Icon(
              isPickupLocationConfirmed ? Icons.location_on : Icons.my_location,
              color: Colors.white,
            ),
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
