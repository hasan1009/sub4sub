import 'package:flutter/material.dart';

import '../utils/text/medium_text.dart';

class ProfileSmallWidget extends StatelessWidget {
  final String text;
  final VoidCallback press;
  Color? textColor;

  ProfileSmallWidget({
    super.key,
    required this.text,
    required this.press,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediumText(
            text: text,
            color: textColor,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white54,
          )
        ],
      ),
    );
  }
}
