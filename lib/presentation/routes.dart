import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {

  'mainPage' : (_) => const MainScreen(),

};