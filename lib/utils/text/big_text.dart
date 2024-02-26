import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final String text;
  FontWeight? weight;

  BigText({super.key, required this.text, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: Dimentions.font24,
          color: Colors.white,
          fontFamily: "robotoreg",
          fontWeight: weight),
    );
  }
}
