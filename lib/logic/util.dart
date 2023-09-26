import 'package:flutter/material.dart';

MaterialStateProperty<Color?> getMaterialStateProperty(Color color) {
  return MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      return color;
    },
  );
}

void showSnackBar(context, message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void removeCurrentSnackbars(context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
}
