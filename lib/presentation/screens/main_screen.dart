import 'package:courier_app/presentation/screens/tracking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/tracking_number_changed_cubit.dart';
import '../widgets/main_drawer.dart';
import 'send_parcel_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    // Convert to MaterialStateProperty<Color?>
    final primaryColorStateProperty = MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return primaryColor;
      },
    );

    Future<void> setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const MainScreen(),
          ),
        );
      }
    }

    return BlocProvider(
      create: (context) => TrackingNumberChanged(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "HPD instant courier",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.apps,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: MainDrawer(onSelectScreen: setScreen),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  child: Container(
                    color: primaryColor,
                    height: 180,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Send & Tracking Your Package',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Please enter your tracking number',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const TextFieldWithTrackingCubit(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  './assets/images/home.jpg',
                  height: 400,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor: primaryColorStateProperty,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SendparcelScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.send_time_extension,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Send a Parcel',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWithTrackingCubit extends StatelessWidget {
  const TextFieldWithTrackingCubit({super.key});

  @override
  Widget build(BuildContext context) {
    final trackingNumberCubit = BlocProvider.of<TrackingNumberChanged>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: trackingNumberCubit.updateTrackingNumber,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.delivery_dining,
                        color: Color.fromARGB(255, 255, 230, 0),
                      ),
                      hintText: 'Enter tracking number',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String trackingNumber = trackingNumberCubit.state;
                    if (trackingNumber.isEmpty) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter the number first'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackingDetailsScreen(
                              trackingNumber: trackingNumber),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  child: const Text(
                    'Track',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
