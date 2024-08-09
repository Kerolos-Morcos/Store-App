import 'package:flutter/material.dart';

Future<bool> showAlertDialog(BuildContext context, String message) async {
  Widget cancelButton = ElevatedButton(
    child: const Text(
      "No",
      style: TextStyle(color: Colors.green),
    ),
    onPressed: () {
      Navigator.of(context).pop(false);
    },
  );
  Widget continueButton = ElevatedButton(
    child: const Text(
      "Yes",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  ); // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Deleting All Products"),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return result ?? false;
}