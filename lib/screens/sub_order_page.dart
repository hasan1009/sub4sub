import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sub4subytbsrt/controllers/controllers.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import 'package:sub4subytbsrt/utils/text/small_text.dart';
import '../utils/text/big_text.dart';
import '../widgets/main_bg.dart';

class SubOrderPage extends StatefulWidget {
  const SubOrderPage({super.key});

  @override
  State<SubOrderPage> createState() => _SubOrderPageState();
}

class _SubOrderPageState extends State<SubOrderPage> {
  final Controllers _controllers = Get.put(Controllers());
  final TextEditingController _videoLinkController = TextEditingController();
  Color submitButtoncolor = Colors.grey;
  List<String> numberList = [
    "140",
    "380",
    "650",
    "1200",
    "2400",
    "5000",
    "6500",
    "12000",
  ];
  List<String> followerList = [
    "10",
    "30",
    "50",
    "100",
    "200",
    "400",
    "500",
    "1000",
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
        itemCount: numberList.length,
        itemBuilder: (context, index) {
          int selectedNumeber = int.parse(numberList[index]);
          int availablePoints = _controllers.points.value;
          return GestureDetector(
            onTap: () {
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
                                          int selectedNumber =
                                              int.parse(numberList[index]);
                                          int orderedSubscribe =
                                              int.parse(followerList[index]);
                                          String videoLink =
                                              _videoLinkController.text.trim();
                                          final FirebaseAuth auth =
                                              FirebaseAuth.instance;
                                          String uid = auth.currentUser!.uid;
                                          RegExp youtubeRegex = RegExp(
                                            r'^(http(s)?:\/\/)?(www\.)?youtu(be\.com|\.be)\/.+',
                                            caseSensitive: false,
                                          );

                                          if (!youtubeRegex
                                              .hasMatch(videoLink)) {
                                            _controllers.showToast(
                                                "The link you provided is not correct");
                                          } else {
                                            if (videoLink.isNotEmpty) {
                                              // _controllers.updateVideoLink(
                                              //    uid, videoLink);
                                              _controllers.orderSubscribe(
                                                  selectedNumber,
                                                  orderedSubscribe,
                                                  videoLink);
                                            }
                                            _controllers.showToast(
                                                "Your order is completed");

                                            Navigator.pop(context);
                                          }
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
                _controllers.showToast("Insufficient coins");
              }
            },
            child: Container(
              margin: EdgeInsets.all(Dimentions.height20),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20,
                  vertical: Dimentions.height15),
              height: Dimentions.height100 * 2,
              width: Dimentions.width100 * 2,
              decoration: BoxDecoration(
                  color: bg3,
                  borderRadius: BorderRadius.circular(Dimentions.radius15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/follower.png",
                    color: followButton,
                    height: Dimentions.height20 + 10,
                  ),
                  Text(
                    followerList[index],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimentions.height10 / 2),
                    decoration: BoxDecoration(
                        color: followButton,
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/likecoin.png",
                            height: Dimentions.height20 + 10),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        Text(
                          numberList[index],
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
