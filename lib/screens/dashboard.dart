import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/controllers/controllers.dart';
import 'package:sub4subytbsrt/screens/video_page-2.dart';
import 'package:sub4subytbsrt/screens/video_page.dart';
import 'package:sub4subytbsrt/screens/profile_screen.dart';
import 'package:sub4subytbsrt/screens/home_page.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:get/get.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';

class DashBoard extends StatefulWidget {
  final Controllers controllers;
  const DashBoard({super.key, required this.controllers});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentTab = 0;
  List<String> videoLinks = [];

  @override
  void initState() {
    fetchvideoLinks();
    super.initState();
  }

  @override
  void dispose() {
    widget.controllers.pageController.dispose();
    videoLinks.clear();

    super.dispose();
  }

  Future<void> fetchvideoLinks() async {
    videoLinks = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("videocampaign")
        .where("isVideo", isEqualTo: true)
        .get();
    setState(() {
      videoLinks =
          querySnapshot.docs.map((e) => e['videoviewLink'] as String).toList();
    });
  }

  void govideoPage() {
    Get.to(() => const VideoPage());
  }

  /*final List<Widget> screens = [
    const HomePage(),
    VideoPage2(videoLinks: videoLinks),
    const ProfileScreen()
  ];*/

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            color: bg2,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const HomePage();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dashboard,
                        color: currentTab == 0 ? Colors.white : Colors.grey,
                      ),
                      Text("Dashboard",
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.white : Colors.grey,
                          ))
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = VideoPage2(videoLinks: videoLinks);
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            gradient: const RadialGradient(
                              colors: [
                                Color(0xFFED4264),
                                Color(0xFFFEDBC2),
                              ],
                              focal: Alignment.center,
                              radius: 50,
                            ),
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius50 * 2)),
                        child: const Icon(
                          Icons.video_camera_back_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const ProfileScreen();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        color: currentTab == 2 ? Colors.white : Colors.grey,
                      ),
                      Text("Settings",
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.white : Colors.grey,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
