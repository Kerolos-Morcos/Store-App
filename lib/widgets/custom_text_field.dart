import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.icon,
    this.transparentColor,
    this.onChanged,
    this.keyboardType
  });
  String? hintText;
  IconData? icon;
  Color? transparentColor;
  Function(String)? onChanged;
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 370,
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          fillColor: Colors.black,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade700),
          suffixIcon: 
           Icon(
              icon,
              color: Colors.black,
            ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }
}