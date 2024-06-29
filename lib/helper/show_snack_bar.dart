import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {MaterialColor? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.fixed,
      elevation: 10,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
    ),
  );
}
