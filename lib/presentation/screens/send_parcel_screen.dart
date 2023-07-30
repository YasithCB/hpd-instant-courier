import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Sendparcel extends StatelessWidget {
  const Sendparcel({super.key});

  @override
  Widget build(BuildContext context) {
    const CameraPosition parisCameraPosition =
        CameraPosition(target: LatLng(48.856613, 2.352222), zoom: 12.0);

    final Completer<GoogleMapController> completer = Completer();

    return GoogleMap(
        onTap: (location) {
          //
        },
        mapType: MapType.normal,
        initialCameraPosition: parisCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          completer.complete(controller);
        });

    //   return FlutterMap(
    //     options: MapOptions(
    //       center: const LatLng(7.8731, 80.7718),
    //       zoom: 9.2,
    //     ),
    //     // nonRotatedChildren: [
    //     //   RichAttributionWidget(
    //     //     attributions: [
    //     //       TextSourceAttribution(
    //     //         'OpenStreetMap contributors',
    //     //         onTap: () =>
    //     //             launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
    //     //       ),
    //     //     ],
    //     //   ),
    //     // ],
    //     children: [
    //       TileLayer(
    //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //         userAgentPackageName: 'com.example.app',
    //       ),
    //     ],

    //   );
  }
}
