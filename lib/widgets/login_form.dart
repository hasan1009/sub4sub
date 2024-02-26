import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/services/auth.dart';

import '../utils/dimentions.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: Dimentions.height20),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline_outlined,
                ),
                labelText: "Email",
                hintText: "Youtube Channel Email",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: Dimentions.height10,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.fingerprint,
                ),
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text("Forgot Password?"))),
          SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () async {
                    await signWithGoogle();
                  },
                  child: Text("Log In".toUpperCase())))
        ],
      ),
    ));
  }
}
