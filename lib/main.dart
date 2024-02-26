import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/screens/dashboard.dart';
import 'package:sub4subytbsrt/screens/login2.dart';
import 'package:get/get.dart';
import 'controllers/controllers.dart';
import 'services/localdb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final controllers = Controllers();

  runApp(MyApp(controllers: controllers));
}

class MyApp extends StatefulWidget {
  final Controllers controllers;
  const MyApp({Key? key, required this.controllers}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;

  Future<void> getLoggedInState() async {
    await LocalDB.getUserID().then((value) {
      setState(() {
        isLogIn = value.toString() != "null";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sub4Sub YT Booster',
      home: isLogIn
          ? DashBoard(
              controllers: widget.controllers,
            )
          : const LogIn2(),
    );
  }
}
