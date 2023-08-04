import 'package:flutter/material.dart';

class TrackingDetailsScreen extends StatefulWidget {
  const TrackingDetailsScreen({super.key, required this.trackingNumber});

  final String trackingNumber;

  @override
  State<TrackingDetailsScreen> createState() => _TrackingDetailsScreenState();
}

class _TrackingDetailsScreenState extends State<TrackingDetailsScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tracking Parcels",
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
      body: Center(
        child: Stepper(
          steps: [
            Step(
              isActive: currentStep == 0,
              title: const Text('Parcel Ready to Dispatch'),
              content: const Text('Info'),
            ),
            Step(
              isActive: currentStep == 1,
              title: const Text('Parcel Dispatched'),
              content: const Text('Info'),
            ),
            Step(
              isActive: currentStep == 2,
              title: const Text('In Transit'),
              content: const Text('Info'),
            ),
            Step(
              isActive: currentStep == 3,
              title: const Text('Delivered'),
              content: const Text('Info'),
            ),
          ],
          onStepTapped: (value) {
            setState(() {
              currentStep = value;
            });
          },
          onStepContinue: () {
            if (currentStep != 3) {
              setState(() {
                currentStep++;
              });
            }
          },
          onStepCancel: () {
            if (currentStep != 0) {
              setState(() {
              currentStep--;
            });
            }
          },
          currentStep: currentStep,
        ),
      ),
    );
  }
}
