import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DeliveryBloc {
  final _deliveryController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get deliveryStream => _deliveryController.stream;

  Future<void> fetchDeliveryData({required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('delivers').where('user.uid', isEqualTo: userId).get();

      List<Map<String, dynamic>> dataList =
          snapshot.docs.map((doc) => doc.data()).toList();

      // Add the dataList to the stream
      _deliveryController.add(dataList);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  // Add a method to dispose the StreamController
  void dispose() {
    _deliveryController.close();
  }
}
