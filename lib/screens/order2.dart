import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sub4subytbsrt/screens/video_order_page.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import 'package:sub4subytbsrt/utils/text/big_text.dart';
import 'package:sub4subytbsrt/utils/text/small_text.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../controllers/video_page_controller.dart';
import '../utils/colors.dart';
import 'sub_order_page.dart';

class Order2 extends StatefulWidget {
  const Order2({super.key});

  @override
  State<Order2> createState() => _Order2State();
}

class _Order2State extends State<Order2> {
  List<Tab> tabs = [
    Tab(
      child: Row(
        children: [
          Lottie.asset("assets/lottie/like2.json"),
          SizedBox(
            width: Dimentions.width10,
          ),
          SmallText(
            text: "Subscribe",
            weight: FontWeight.w600,
          ),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
          Lottie.asset("assets/lottie/videocoin.json"),
          SizedBox(
            width: Dimentions.width10,
          ),
          SmallText(
            text: "Video View",
            weight: FontWeight.w600,
          ),
        ],
      ),
    ),
  ];

  List<Widget> tabsContent = [
    const SubOrderPage(),
    const VideoOrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Controllers ctrl = Get.put(Controllers());
    final VideoPageController controller = Get.put(VideoPageController());
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            backgroundColor: bg1,
            appBar: AppBar(
              title: BigText(
                text: "Order Page",
                weight: FontWeight.bold,
              ),
              backgroundColor: bg1,
              toolbarHeight: Dimentions.height10 * 9,
              elevation: 0.0,
              centerTitle: true,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: TabBar(
                    tabs: tabs,
                    isScrollable: true,
                    indicatorWeight: 5,
                    indicatorColor: followButton,
                  )),
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: Dimentions.width10),
                      decoration: BoxDecoration(
                          color: bg3,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius50)),
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
            body: TabBarView(children: tabsContent)));
  }
}
