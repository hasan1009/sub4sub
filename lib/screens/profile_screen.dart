import 'package:flutter/material.dart';
import 'package:sub4subytbsrt/screens/campaign_page.dart';
import 'package:sub4subytbsrt/screens/order2.dart';
import 'package:sub4subytbsrt/services/localdb.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import 'package:sub4subytbsrt/widgets/main_bg.dart';
import 'package:sub4subytbsrt/widgets/policy_dialog/policy_dialog.dart';
import '../controllers/controllers.dart';
import '../controllers/video_page_controller.dart';
import '../services/auth.dart';
import '../utils/colors.dart';
import '../utils/text/big_text.dart';
import '../utils/text/small_text.dart';
import '../widgets/profile_big-widget.dart';
import '../widgets/profile_small_widget.dart';
import 'package:lottie/lottie.dart';
import 'fortune-wheel.dart';
import 'login2.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "User Name";
  String proUrl = "--";

  Future<void> getUserDet() async {
    await LocalDB.getName().then((value) {
      setState(() {
        name = value.toString();
      });
    });

    await LocalDB.getUrl().then((value) {
      setState(() {
        proUrl = value.toString();
      });
    });
  }

  ImageProvider rightImage() {
    if (proUrl != "--") {
      return NetworkImage(proUrl);
    } else {
      return const AssetImage("assets/images/placeholder.png");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDet();
  }

  @override
  Widget build(BuildContext context) {
    final Controllers ctrl = Get.put(Controllers());
    final VideoPageController controller = Get.put(VideoPageController());
    return Scaffold(
        backgroundColor: bg1,
        appBar: AppBar(
          title: BigText(
            text: "profile",
            weight: FontWeight.bold,
          ),
          backgroundColor: bg1,
          toolbarHeight: Dimentions.height10 * 7,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: Dimentions.width10),
                  decoration: BoxDecoration(
                      color: bg3,
                      borderRadius: BorderRadius.circular(Dimentions.radius50)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: Dimentions.width10),
                        decoration: BoxDecoration(
                            color: bg3,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius50)),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/likecoin.png",
                                    height: 30, fit: BoxFit.cover),
                                //Image.asset("assets/images/coin.png"),
                                SizedBox(
                                  width: Dimentions.width5,
                                ),
                                Obx(
                                  () => Text(
                                    "${ctrl.points}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimentions.font20),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimentions.width5,
                                )
                              ],
                            ),
                            Row(children: [
                              Image.asset(
                                "assets/images/vidcoin.png",
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: Dimentions.width5,
                              ),
                              Obx(
                                () => Text(
                                  "${controller.videoCoins}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimentions.font20,
                                  ),
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        body: MainBgDesign(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dimentions.height10 / 2),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Dimentions.height100 + 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        Container(
                          height: Dimentions.height100 + 15,
                          width: Dimentions.width100 + 15,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5,
                                  color: followButton,
                                  strokeAlign: BorderSide.strokeAlignOutside),
                              borderRadius: BorderRadius.circular(
                                  Dimentions.radius50 * 2),
                              image: DecorationImage(
                                  image: rightImage(), fit: BoxFit.cover)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const FortunePage());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 22),
                            decoration: BoxDecoration(
                                color: bg3,
                                borderRadius:
                                    BorderRadius.circular(Dimentions.radius15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/lottie/fortune.json",
                                    height: Dimentions.height50),
                                SizedBox(
                                  width: Dimentions.width5,
                                ),
                                SmallText(
                                  text: 'Lucky Coins',
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileBigWidget(
                    colomn: Column(
                      children: [
                        ProfileSmallWidget(
                          text: "Orders",
                          press: () {
                            Get.to(() => const Order2());
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  ProfileBigWidget(
                    colomn: Column(
                      children: [
                        ProfileSmallWidget(
                          text: "About",
                          press: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const policyDialog(
                                      mdFilename: "about.md");
                                });
                          },
                        ),
                        SizedBox(
                          height: Dimentions.height20,
                        ),
                        ProfileSmallWidget(
                            text: "Privacy Policy",
                            press: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const policyDialog(
                                        mdFilename: "privacy_policy.md");
                                  });
                            }),
                        SizedBox(
                          height: Dimentions.height20,
                        ),
                        ProfileSmallWidget(
                            text: "FAQ",
                            press: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const policyDialog(
                                        mdFilename: "faq.md");
                                  });
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  ProfileBigWidget(
                    colomn: Column(
                      children: [
                        ProfileSmallWidget(
                            text: "Campaign",
                            press: () {
                              Get.to(() => const CampaignPage());
                            }),
                        SizedBox(
                          height: Dimentions.height20,
                        ),
                        ProfileSmallWidget(
                            text: "Share",
                            press: () {
                              Share.share(
                                "Download the Sub4Sub YTBooster app: https://com.example.sub4subytbsrt",
                                subject: "Bangla Job Quiz",
                                sharePositionOrigin:
                                    const Rect.fromLTWH(0, 0, 10, 10),
                              );
                            }),
                        SizedBox(
                          height: Dimentions.height20,
                        ),
                        ProfileSmallWidget(
                            text: "Ratings",
                            press: () {
                              _showRatingDialog();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  ProfileBigWidget(
                    colomn: Column(
                      children: [
                        ProfileSmallWidget(
                            text: "Logout",
                            textColor: followButton,
                            press: () async {
                              await signOut();
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const LogIn2()));
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _showRatingDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
            title: const Text(
              "Rate this app",
              textAlign: TextAlign.center,
            ),
            submitButtonText: "SUBMIT",
            onSubmitted: (response) {
              StoreRedirect.redirect(androidAppId: "com.example.sub4subytbsrt");
            },
          );
        });
  }
}
