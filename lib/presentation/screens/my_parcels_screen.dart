import 'package:courier_app/data/data.dart';
import 'package:flutter/material.dart';

import '../../logic/delivery/delivery_block.dart';

class MyParcelsScreen extends StatefulWidget {
  const MyParcelsScreen({super.key});

  @override
  State<MyParcelsScreen> createState() => _MyParcelsScreenState();
}

class _MyParcelsScreenState extends State<MyParcelsScreen> {
  final DeliveryBloc _deliveryBloc = DeliveryBloc();

  @override
  void initState() {
    super.initState();
    // Fetch delivery data when the widget is initialized
    _deliveryBloc.fetchDeliveryData(userId: currentUser!.uid);
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the block to avoid memory leaks
    _deliveryBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final primaryColorStateProperty = MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return primaryColor;
      },
    );

    Widget deliversListView = StreamBuilder<List<Map<String, dynamic>>>(
      stream: _deliveryBloc.deliveryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error fetching data: ${snapshot.error}');
        } else if(snapshot.data!.isEmpty) {
          return const Center(child: Text('There are no parcels send yet!'));
        }else {
          List<Map<String, dynamic>> dataList = snapshot.data!;

          // Use dataList to display your data, e.g., ListView.builder
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> itemData = dataList[index];
              return ListTile(
                title: Text('Address: ${itemData['address']}'),
                subtitle: Text('Location: ${itemData['location']}'),
                // Add more UI elements to display other details as needed
              );
            },
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Parcels",
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
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: deliversListView,
          ),
        ],
      ),
    );
  }
}
