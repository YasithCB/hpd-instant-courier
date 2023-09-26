import 'package:cloud_firestore/cloud_firestore.dart';

class DriverRepo {
  Future<List<DocumentSnapshot>> getAllDrivers() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('riders').get();

    // The querySnapshot contains all the documents in the 'drivers' collection
    // You can access individual documents using querySnapshot.docs
    List<DocumentSnapshot> driverDocuments = querySnapshot.docs;

    return driverDocuments;
  } catch (e) {
    print("Error fetching riders: $e");
    return [];
  }
}
}
