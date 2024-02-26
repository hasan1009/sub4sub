import 'package:flutter/material.dart';

import '../screens/login2.dart';
import '../services/auth.dart';
import '../utils/dimentions.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.proUrl,
    required this.name,
  });

  final String proUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(proUrl),
          radius: Dimentions.radius50 * 2,
        ),
        SizedBox(
          height: Dimentions.height10,
        ),
        Text(
          name,
          style: TextStyle(fontSize: Dimentions.font30),
        ),
        Text(
          "support@sub4subytbooster.com",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        ElevatedButton(
            onPressed: () async {
              await signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LogIn2()));
            },
            child: const Text("LOGOUT"))
      ],
    );
  }
}
