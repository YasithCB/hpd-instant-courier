import 'package:courier_app/presentation/screens/send_parcel_screen.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
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
      ),
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.delivery_dining,
                                    color: Color.fromARGB(255, 255, 230, 0),
                                  ),
                                  suffix: ElevatedButton(
                                    onPressed: () {
                                      // Handle button press here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                    ),
                                    child: const Text(
                                      'Track',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  hintText: 'Enter tracking number',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                'asserts/images/home.jpg',
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
                        builder: (context) => const Sendparcel(),
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
    );
  }
}
