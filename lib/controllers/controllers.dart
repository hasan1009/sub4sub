import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Controllers extends GetxController {
  final CollectionReference _hmCollection =
      FirebaseFirestore.instance.collection("users");

  //String userId = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot? profileSnapshot;
  int currentpageIndex = 0;
  RxInt currentIndex = 0.obs;
  RxInt points = 0.obs;
  PageController pageController = PageController();
  RxBool isLogIn = false.obs;
  RxBool isLoading = true.obs;
  RxBool showLottie = false.obs;

  //Link List
  final RxList<String> _profileLinks = <String>[].obs;
  final RxList<String> _videoLinks = <String>[].obs;
  final RxList<String> _videoviewLinks = <String>[].obs;
  List<String> _ids = [];

  //For fetch Outside
  List<String> get profileLinks => _profileLinks;
  List<String> get videoLinks => _videoLinks;
  List<String> get videoviewLinks => _videoviewLinks;
  List<String> get ids => _ids;

  @override
  void onReady() {
    super.onReady();
    loadPoints();
    fetchProfileLinks();
    fetchvideoviewLinks();
  }

  Future<void> loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    points.value = prefs.getInt('points') ?? 0;
  }

  Future<void> savePoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', points.value);
  }

  void nextPage() {
    if (currentIndex < profileLinks.length) {
      currentIndex++;
      update();
    } else {
      showLottie.value = true;
      update();
      showToast("List is finished");
    }
  }

  void updateGetSubscribe() async {
    if (_ids.isNotEmpty && currentIndex.value < _ids.length) {
      String userId = _ids[currentIndex.value];
      _hmCollection.doc(userId).update({
        "getSubscribe": FieldValue.increment(1),
        "totalSubscribe": FieldValue.increment(1),
      });
      DocumentSnapshot userDoc = await _hmCollection.doc(userId).get();
      int orderSubscribe = userDoc['orderSubscribe'];
      int getSubscribe = userDoc['getSubscribe'];
      if (orderSubscribe == getSubscribe) {
        // Update the isDisplay field to false
        await _hmCollection.doc(userId).update(
            {'isDisplay': false, 'orderSubscribe': 0, 'getSubscribe': 0});
      }
    }
  }

  void updateGetvideo() async {
    if (_ids.isNotEmpty && currentIndex.value < _ids.length) {
      String userId = _ids[currentIndex.value];
      _hmCollection.doc(userId).update({"getVideo": FieldValue.increment(2)});
      DocumentSnapshot userdoc = await _hmCollection.doc(userId).get();
      int orderVideo = userdoc['orderVideo'];
      int getVideo = userdoc['getVideo'];
      if (orderVideo == getVideo) {
        await _hmCollection
            .doc(userId)
            .update({"isVideo": false, "orderVideo": 0, "getVideo": 0});
      }
    }
  }

  void clickSubscribebutton() async {
    if (currentIndex.value < _videoLinks.length) {
      String youtubeLink = _videoLinks[currentIndex.value];
      final youtubeUrl = Uri.parse(youtubeLink);
      launchUrl(youtubeUrl, mode: LaunchMode.externalApplication);
      updateGetSubscribe();

      Future.delayed(const Duration(seconds: 7), () {
        points += 10;
        savePoints();
        nextPage();
      });
    } else {
      showToast("List is finished");
    }
  }

  /*Future<void> updateVideoLink(String uid, String videoLink) async {
    DocumentReference userRef = _hmCollection.doc(uid);

    await userRef.update({"videoLink": videoLink});
  }*/

  Future<void> orderSubscribe(
      int pointsToDeduct, int orderedSubscribe, String videoLink) async {
    //String videocampaignId = "fgrgsfgsfgfghrtghsetudghj";
    String userId = FirebaseAuth.instance.currentUser!.uid;
    if (pointsToDeduct <= points.value) {
      points -= pointsToDeduct;
      savePoints();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("subscribeCampaign")
          .doc()
          .set({
        //"videocampaignId": videocampaignId,
        "videoLink": videoLink,
        "isDisplay": true,
        'getSubscribe': 0,
        "orderSubscribe": orderedSubscribe,
        "totalSubscribe": 0,
      });
    }
  }

  Future<void> fetchProfileLinks() async {
    _ids = [];
    _profileLinks.value = <String>[].obs;
    _videoLinks.value = <String>[].obs;
    isLoading.value = false;
    update();
    QuerySnapshot querySnapshot =
        await _hmCollection.where("isDisplay", isEqualTo: true).get();
    _profileLinks.value =
        querySnapshot.docs.map((doc) => doc['photoUrl'] as String).toList();
    _videoLinks.value =
        querySnapshot.docs.map((doc) => doc['videoLink'] as String).toList();
    _ids = querySnapshot.docs.map((doc) => doc.id).toList();
    profileSnapshot = querySnapshot;
    isLoading.value = false;
    update();
  }

  Future<void> fetchvideoviewLinks() async {
    _videoviewLinks.value = [];
    try {
      // Replace 'your_collection_path' with the actual path to your Firestore collection
      QuerySnapshot userQuerySnapshot =
          await FirebaseFirestore.instance.collection("users").get();

      for (QueryDocumentSnapshot userDoc in userQuerySnapshot.docs) {
        String userId = userDoc.id;

        QuerySnapshot videoQuerySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("videoCampaign")
            .where("isVideo", isEqualTo: true)
            .get();

        _videoviewLinks.addAll(videoQuerySnapshot.docs
            .map((doc) => doc['videViewLink'] as String));
      }
    } catch (e) {
      print("Error fetching video view links: $e");
    }

    update();
  }

  Future<void> setCurrentpageIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'currentPageIndex',
      currentpageIndex,
    );
  }

  Future<void> getCurrentPageIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt('currentPageIndex') ?? 0;
  }

  void pageControll() {
    pageController = PageController(initialPage: currentpageIndex);
    getCurrentPageIndex();
    //currentpageIndex = 0;
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _profileLinks.clear();
    _videoLinks.clear();
    _videoviewLinks.clear();
    _ids.clear();
  }
}
