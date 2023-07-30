import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Sendparcel extends StatelessWidget {
  const Sendparcel({super.key});

  @override
  Widget build(BuildContext context) {
    const CameraPosition slCameraPosition =
        CameraPosition(target: LatLng(7.8731, 80.7718), zoom: 8.0);

    final Completer<GoogleMapController> completer = Completer();

    return GoogleMap(
        onTap: (location) {
          //
        },
        mapType: MapType.normal,
        initialCameraPosition: slCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          completer.complete(controller);
        });
  }
}
