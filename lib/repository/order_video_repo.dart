import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/video_campaign_model.dart';

class OrderVideoRepo extends GetxController {
  static OrderVideoRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  orderVideo(VideoCampaignModel videoCampaignModel) async {
    await _db
        .collection("videocampaign")
        .add(videoCampaignModel.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Successfully added a campaign",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((erroe, stackTrace) {
      Get.snackbar("Error", "Something went wrong, Try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }
}
