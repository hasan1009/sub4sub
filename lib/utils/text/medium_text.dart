import 'package:flutter/material.dart';

import '../dimentions.dart';

// ignore: must_be_immutable
class MediumText extends StatelessWidget {
  final String text;
  Color? color;
  FontWeight? weight;
  MediumText({
    super.key,
    required this.text,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Dimentions.font20,
          color: color,
          fontFamily: "robotoreg",
          fontWeight: FontWeight.bold),
    );
  }
}
