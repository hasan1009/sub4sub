import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VideoPage3Repo extends GetxController {
  static VideoPage3Repo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<String>> fetchVideoViewLink() async {
    final snapshot = await _db
        .collection("videocampaign")
        .where("isVideo", isEqualTo: true)
        .get();

    final videViewLink =
        snapshot.docs.map((e) => e["videoviewLink"] as String).toList();

    return videViewLink;
  }

  /*Future<void> updateGetVideoView(VideoCampaignModel videoCampaignModel){
    videoCampaignModel.toJson()*/
  // }
}
