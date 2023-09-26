
import 'package:courier_app/presentation/screens/send_parcel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final _firebase = FirebaseAuth.instance;

class AuthScreenTemp extends StatefulWidget {
  const AuthScreenTemp({super.key, required this.isAdmin});

  final bool isAdmin;

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenTempState();
  }
}

class _AuthScreenTempState extends State<AuthScreenTemp> {
  final _form = GlobalKey<FormState>();
  bool _isAdmin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';

  final _isAuthenticating = false;

  @override
  void initState() {
    _isAdmin = widget.isAdmin;
    super.initState();
  }

  void _submit() async {
    // if (!_form.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Something went wrong. Try again later!'),
    //     ),
    //   );
    //   return;
    // }
    // _form.currentState!.save();
    // try {
    //   setState(() {
    //     _isAuthenticating = true;
    //   });

    //   await _firebase.signInWithEmailAndPassword(
    //     email: _enteredEmail,
    //     password: _enteredPassword,
    //   );
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'email-already-in-use') {
    //     //...
    //   }
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(e.message ?? 'Authentication failed'),
    //     ),
    //   );
    // }
    // setState(() {
    //   _isAuthenticating = false;
    // });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SendParcelScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    MaterialStateProperty<Color?> getMaterialStateProperty(Color color) {
      return MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return color;
        },
      );
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                width: 300,
                child: Image.asset('assets/images/home.jpg'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            SizedBox(
                              height: 50,
                              width: 350,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      getMaterialStateProperty(primaryColor),
                                ),
                                onPressed: _submit,
                                child: Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
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
