import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sub4subytbsrt/controllers/controllers.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import 'package:lottie/lottie.dart';
import '../utils/text/big_text.dart';
import '../utils/text/medium_text.dart';
import '../utils/text/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListFinished = false;
  List<String> videoLinks = [];
  Controllers c = Get.put(Controllers());
  //int currentPageindex = 0;
  bool showLottie = false;

  @override
  void initState() {
    super.initState();
    c.pageControll();
    //c.fetchProfileLinks();
  }

  @override
  void dispose() {
    c.setCurrentpageIndex();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bg1,
      appBar: AppBar(
        title: BigText(
          text: "Home",
          weight: FontWeight.bold,
        ),
        backgroundColor: bg1,
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
                    SizedBox(
                      width: Dimentions.width5 - 2,
                    ),
                    Image.asset("assets/images/likecoin.png",
                        height: 30, fit: BoxFit.cover),
                    SizedBox(
                      width: Dimentions.width5,
                    ),
                    Obx(
                      () => Text(
                        "${c.points}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimentions.font20 - 2),
                      ),
                    ),
                    SizedBox(
                      width: Dimentions.width15,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            await c.fetchProfileLinks();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimentions.height20 * 2,
                horizontal: Dimentions.width10),
            width: w,
            height: h,
            decoration: BoxDecoration(
              color: bg2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimentions.radius30),
                topLeft: Radius.circular(Dimentions.radius30),
              ),
            ),
            child: Column(
              children: [
                Container(
                    height: h * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: bg3,
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius20)),
                    child: Obx(() => c.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: followButton,
                            ),
                          )
                        : c.showLottie.value
                            ? LottieBuilder.asset("assets/lottie/giftbox.json")
                            : (c.currentIndex < c.profileLinks.length)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: Dimentions.radius50 * 2,
                                        backgroundColor: followButton,
                                        backgroundImage: NetworkImage(
                                          c.profileLinks[c.currentIndex.value],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimentions.height20 + 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              c.nextPage();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Dimentions.width20 * 2,
                                                vertical: Dimentions.height15,
                                              ),
                                              decoration: BoxDecoration(
                                                color: skipButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimentions.radius50,
                                                ),
                                              ),
                                              child: Center(
                                                child: MediumText(text: "Skip"),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              //clickSubscribebutton();
                                              c.clickSubscribebutton();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimentions.width20,
                                                vertical: Dimentions.height15,
                                              ),
                                              decoration: BoxDecoration(
                                                color: followButton,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimentions.radius50,
                                                ),
                                              ),
                                              child: Center(
                                                child: MediumText(
                                                    text: "Subscribe +10"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : LottieBuilder.asset(
                                    "assets/lottie/giftbox.json"))),
                Container(
                  margin: EdgeInsets.only(top: Dimentions.height20),
                  padding: EdgeInsets.all(Dimentions.height15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: bg3,
                      borderRadius: BorderRadius.circular(Dimentions.radius20)),
                  child: Center(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/lottie/tips.json",
                              height: Dimentions.height20 * 2,
                              fit: BoxFit.cover),
                          MediumText(text: "Tips"),
                        ],
                      ),
                      SizedBox(height: Dimentions.height10),
                      SmallText(
                        text:
                            "1. Click Subscribe button    2. Open Youtube    \n3. Subscribe    4. Back to Sub4Sub    5. Get Coins",
                        color: Colors.white54,
                      ),
                      SizedBox(
                        height: Dimentions.height20 + 5,
                      ),
                      MediumText(
                        text: "If Unsubscribe coins will be removed...",
                        color: Colors.amberAccent,
                      ),
                      SizedBox(
                        height: Dimentions.height10,
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
