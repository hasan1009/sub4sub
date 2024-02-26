import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sub4subytbsrt/models/video_campaign_model.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import 'package:sub4subytbsrt/utils/text/small_text.dart';
import '../controllers/order_video_controller.dart';
import '../controllers/video_page_controller.dart';
import '../utils/text/big_text.dart';
import '../widgets/main_bg.dart';

class VideoOrderPage extends StatefulWidget {
  const VideoOrderPage({super.key});

  @override
  State<VideoOrderPage> createState() => _VideoOrderPageState();
}

class _VideoOrderPageState extends State<VideoOrderPage> {
  ///final Controllers _controllers = Get.put(Controllers());

  final orderVideoController = Get.put(OrderVideoController());
  final TextEditingController _videoLinkController = TextEditingController();
  final _videoPageController = Get.put(VideoPageController());
  Color submitButtoncolor = Colors.grey;
  List<String> coinList = [
    //"200",
    "0",
    "400",
    "800",
    "1000",
    "2000",
    "3000",
    "4300",
    "5000",
  ];
  List<String> viewtimeList = [
    //"10",
    "2",
    "20",
    "40",
    "60",
    "120",
    "180",
    "240",
    "300",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      body: MainBgDesign(
          child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: viewtimeList.length,
        itemBuilder: (context, index) {
          int selectedNumeber = int.parse(coinList[index]);
          int availablePoints = _videoPageController.videoCoins.value;
          return GestureDetector(
            onTap: () {
              /*int ordereVideo = int.parse(viewtimeList[index]);
              final FirebaseAuth _auth = FirebaseAuth.instance;
              final orderVideo = VideoCampaignModel(
                  email: _auth.currentUser!.email.toString(),
                  videoviewLink: _videoLinkController.text.trim(),
                  orderVideo: ordereVideo,
                  totalvideoView: 0,
                  getvideoView: 0,
                  isVideo: true);
              orderVideoController.orderVideo(orderVideo);*/
              if (selectedNumeber <= availablePoints) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: Dimentions.height100 * 7,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            height: Dimentions.height100 * 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    Dimentions.radius20 * 2)),
                            child: Scaffold(
                              resizeToAvoidBottomInset: false,
                              backgroundColor: Colors.transparent,
                              body: Column(
                                children: [
                                  const Text(
                                    "Video Link",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          text:
                                              "Step 1: Open your Youtube app.",
                                          color: Colors.black,
                                        ),
                                        SmallText(
                                          text: "Step 2: Go to your channel.",
                                          color: Colors.black,
                                        ),
                                        SmallText(
                                          text:
                                              "Step 3: Open any video and tap on share button",
                                          color: Colors.black,
                                        ),
                                        SmallText(
                                          text:
                                              "Step 4: Copy link and paste it here.",
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Form(
                                      child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: _videoLinkController,
                                        keyboardType: TextInputType.none,
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Image.asset(
                                                "assets/images/ytlogo.png",
                                                height: 15,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimentions.radius20),
                                                borderSide:
                                                    const BorderSide(width: 4)),
                                            hintText:
                                                "Paste your YT video link here..."),
                                      ),
                                      SizedBox(
                                        height: Dimentions.height50,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          int ordereVideo =
                                              int.parse(viewtimeList[index]);

                                          final FirebaseAuth _auth =
                                              FirebaseAuth.instance;
                                          String email = _auth
                                              .currentUser!.email
                                              .toString();
                                          final orderVideo = VideoCampaignModel(
                                              email: email,
                                              videoviewLink:
                                                  _videoLinkController.text
                                                      .trim(),
                                              orderVideo: ordereVideo,
                                              totalvideoView: 0,
                                              getvideoView: 0,
                                              isVideo: true);
                                          orderVideoController
                                              .orderVideo(orderVideo);
                                          // Navigator.pop(context);
                                          Get.back();

                                          /* int selectedNumber =
                                              int.parse(coinList[index]);
                                          int orderedSubscribe =
                                              int.parse(viewtimeList[index]);

                                          String videoLink =
                                              _videoLinkController.text.trim();

                                          RegExp youtubeRegex = RegExp(
                                            r'^(http(s)?:\/\/)?(www\.)?youtu(be\.com|\.be)\/.+',
                                            caseSensitive: false,
                                          );

                                          if (!youtubeRegex
                                              .hasMatch(videoLink)) {
                                            _videoPageController.showToast(
                                                "The link you providednis not correct");
                                          } else {
                                            if (videoLink.isNotEmpty) {
                                              _videoPageController.orderVideo(
                                                  selectedNumber,
                                                  orderedSubscribe,
                                                  videoLink);
                                            }
                                            _videoPageController.showToast(
                                                "Your order is completed");

                                            Navigator.pop(context);*/
                                          //}
                                        },
                                        child: Container(
                                          height: Dimentions.height50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: followButton,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                              child: BigText(
                                            text: "SUBMIT",
                                            weight: FontWeight.bold,
                                          )),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                _videoPageController.showToast("Insufficient coins");
              }
            },
            child: Container(
              margin: EdgeInsets.all(Dimentions.height20),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20,
                  vertical: Dimentions.height10),
              height: Dimentions.height100 * 2,
              width: Dimentions.width100 * 2,
              decoration: BoxDecoration(
                  color: bg3,
                  borderRadius: BorderRadius.circular(Dimentions.radius15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/vid.png",
                    color: followButton,
                    height: Dimentions.height20 + 20,
                  ),
                  Text(
                    "${viewtimeList[index]} min",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimentions.height10 / 2),
                    decoration: BoxDecoration(
                        color: bg2,
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/vidcoin.png",
                            height: Dimentions.height20 + 10),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        Text(
                          coinList[index],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
