import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';

class MainBgDesign extends StatelessWidget {
  final Widget child;
  const MainBgDesign({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimentions.height15),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bg2,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimentions.radius30),
            topLeft: Radius.circular(Dimentions.radius30),
          )),
      child: child,
    );
  }
}
