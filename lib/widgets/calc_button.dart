import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  CalcButton(
      {super.key,
      required this.buttonText,
      required this.buttonColor,
      required this.textColor,
      required this.ontap});

  String buttonText;
  Color buttonColor;
  Color textColor;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: buttonColor,
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
