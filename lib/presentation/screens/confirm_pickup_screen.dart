import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_app/data/data.dart';
import 'package:courier_app/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmPickupScreen extends StatefulWidget {
  const ConfirmPickupScreen(
      {super.key, required this.location, required this.address});

  final LatLng location;
  final String address;

  @override
  State<ConfirmPickupScreen> createState() => _ConfirmPickupScreenState();
}

class _ConfirmPickupScreenState extends State<ConfirmPickupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _parcelDescFocusNode = FocusNode();
  String _parcelDesc = '';
  String _contact = '';
  String _specialMessage = '';

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> submitData() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String documentId =
          '${widget.location.latitude}_${widget.location.longitude}';

      await FirebaseFirestore.instance
          .collection('delivers')
          .doc(documentId)
          .set({
        'location':
            GeoPoint(widget.location.latitude, widget.location.longitude),
        'address': widget.address,
        'parcelDesc': _parcelDesc,
        'contact': _contact,
        'specialMessage': _specialMessage,
        'user': {
          'uid': currentUser?.uid,
          'displayName': currentUser?.displayName,
          'email': currentUser?.email,
        },
      });

      showSnackBar('Pickup request sent SuccessFully!');

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      showSnackBar('Something went wrong.Fill all required fields!');
    }
  }

  @override
  void dispose() {
    _parcelDescFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    Widget form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Address    :  ${widget.address}",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelText: 'What are in your Parcel?',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the parcel description';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _parcelDesc = value;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              // Add additional phone number validation if needed
              return null;
            },
            onChanged: (value) {
              setState(() {
                _contact = value;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelText: 'Special message for driver (Optional)',
            ),
            onChanged: (value) {
              setState(() {
                _specialMessage = value;
              });
            },
          ),
          const SizedBox(height: 50),
          Text(
            "We will send a driver to pickup your parcel after you confirm this. We will share the driver details with you",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: ElevatedButton.icon(
              onPressed: () {
                submitData();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return const Color.fromARGB(255, 255, 230, 0);
                  },
                ),
              ),
              icon: const Icon(
                Icons.delivery_dining,
              ),
              label: Text(
                'Confirm Pickup',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Confirm Pickup",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: form,
          ),
        ),
      ),
    );
  }
}
