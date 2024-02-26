import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCampaignModel {
  String email;
  String videoviewLink;
  int orderVideo;
  int totalvideoView;
  int getvideoView;
  bool isVideo;

  VideoCampaignModel({
    required this.email,
    required this.videoviewLink,
    required this.orderVideo,
    required this.totalvideoView,
    required this.getvideoView,
    required this.isVideo,
  });

  toJson() {
    return {
      "email": email,
      "videoviewLink": videoviewLink,
      "orderVideo": orderVideo,
      "totalvideoView": totalvideoView,
      "getvideoView": getvideoView,
      "isVideo": isVideo
    };
  }

  factory VideoCampaignModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return VideoCampaignModel(
      email: data['email'],
      videoviewLink: data['videoviewLink'],
      orderVideo: data['orderVideo'],
      totalvideoView: data['totalvideoView'],
      getvideoView: data['getvideoView'],
      isVideo: data['isVideo'],
    );
  }
}
