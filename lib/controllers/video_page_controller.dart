import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoPageController extends GetxController {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  RxInt videoCoins = 0.obs;
  Future<void> loadVideoPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    videoCoins.value = prefs.getInt('videopoints') ?? 0;
  }

  Future<void> saveVideoPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('videopoints', videoCoins.value);
  }

  void increaseVideoPoints() {
    videoCoins += 10;
  }

  @override
  void onReady() {
    super.onReady();
    loadVideoPoints();
  }

  Future<void> orderVideo(
      int pointsToDeduct, int ordereVideo, String videoLink) async {
    if (pointsToDeduct <= videoCoins.value) {
      videoCoins -= pointsToDeduct;
      saveVideoPoints();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("videoCampaign")
          .doc()
          .set({
        "videViewLink": videoLink,
        "orderVideo": ordereVideo,
        "getVideo": 0,
        "totalVideoVoew": 0,
        "isVideo": true,
      });
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
