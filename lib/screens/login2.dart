import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/screens/dashboard.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import '../controllers/controllers.dart';
import '../services/auth.dart';
import 'package:lottie/lottie.dart';

import '../utils/text/medium_text.dart';

class LogIn2 extends StatefulWidget {
  const LogIn2({super.key});

  @override
  State<LogIn2> createState() => _LogIn2State();
}

class _LogIn2State extends State<LogIn2> {
  final Controllers controllers = Controllers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Lottie.asset("assets/lottie/rocket.json",
                repeat: true, reverse: false, height: 300),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await signWithGoogle();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return DashBoard(
                    controllers: controllers,
                  );
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimentions.height20,
                    vertical: Dimentions.height15),
                height: Dimentions.height50 + 5,
                width: Dimentions.width100 * 2.5,
                decoration: BoxDecoration(
                    color: followButton,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/google.json",
                          height: Dimentions.height15 * 2,
                          reverse: true,
                          repeat: true),
                      SizedBox(
                        width: Dimentions.width10,
                      ),
                      MediumText(text: "Login with Google")
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimentions.height20 * 3,
            )
          ],
        ),
      ),
    );
  }
}
