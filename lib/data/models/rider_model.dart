import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String id; // You can include a unique identifier for the rider
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final GeoPoint currentLocation; // Assuming you are using Firestore's GeoPoint

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.currentLocation,
  });

  factory Driver.fromMap(String id, Map<String, dynamic> data) {
    return Driver(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      currentLocation: data['currentLocation'] ?? const GeoPoint(0, 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'currentLocation': currentLocation,
    };
  }
}
