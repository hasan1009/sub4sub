import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';

class ProfileBigWidget extends StatelessWidget {
  final Widget colomn;
  const ProfileBigWidget({
    super.key,
    required this.colomn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(Dimentions.height20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: bg3,
            borderRadius: BorderRadius.circular(Dimentions.radius15)),
        child: colomn);
  }
}
