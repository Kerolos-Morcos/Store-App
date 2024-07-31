import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.buttonTextColor,
      required this.buttonBackgroundColor});
  final String buttonText;
  final VoidCallback onTap;
  final Color buttonTextColor;
  final Color buttonBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: 60,
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
