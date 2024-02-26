import 'package:flutter/material.dart';
import '../dimentions.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  FontWeight? weight;
  SmallText(
      {super.key, required this.text, this.color = Colors.white, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Dimentions.font15,
          color: color,
          fontFamily: "robotoreg",
          height: 1.8,
          fontWeight: weight),
    );
  }
}
