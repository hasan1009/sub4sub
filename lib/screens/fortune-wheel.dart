import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sub4subytbsrt/controllers/controllers.dart';
import 'package:sub4subytbsrt/utils/colors.dart';
import 'package:sub4subytbsrt/utils/dimentions.dart';
import 'package:sub4subytbsrt/utils/text/big_text.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sub4subytbsrt/utils/text/medium_text.dart';
import 'package:sub4subytbsrt/utils/text/small_text.dart';
import 'package:get/get.dart';
import 'package:sub4subytbsrt/widgets/main_bg.dart';
import '../controllers/video_page_controller.dart';

class FortunePage extends StatefulWidget {
  const FortunePage({super.key});

  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  final Controllers _ctrl = Get.put(Controllers());
  final VideoPageController _controller = Get.put(VideoPageController());
  final selected = BehaviorSubject<int>();
  List<int> items = [20, 60, 500, 40, 15];
  DateTime? lastSpinTime;
  int rewards = 0;

  @override
  void initState() {
    super.initState();
    loadLastSpinTime();
    //loadButtonColor();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  bool canSpinWheel() {
    if (lastSpinTime == null) {
      return true;
    }

    final currentTime = DateTime.now();
    final timeDifference = currentTime.difference(lastSpinTime!);
    return timeDifference.inHours >= 1;
  }

  void showRemainingTimeMessage() {
    final currentTime = DateTime.now();
    final timedifference = currentTime.difference(lastSpinTime!);
    final remainingTime = const Duration(hours: 1) - timedifference;
    _ctrl
        .showToast("Next spin available in ${remainingTime.inMinutes} Minutes");
  }

  void onTapGoButton() async {
    final prefs = await SharedPreferences.getInstance();
    if (canSpinWheel()) {
      if (_ctrl.points.value >= 20 && _controller.videoCoins >= 20) {
        _ctrl.points -= 20;
        _controller.videoCoins -= 20;
        _ctrl.savePoints();

        setState(() {
          selected.add(Fortune.randomInt(0, items.length));
        });
        lastSpinTime = DateTime.now();
        await prefs.setString('lastSpinTime', lastSpinTime.toString());
      } else {
        _ctrl.showToast("Insufficient coins");
      }
    } else {
      showRemainingTimeMessage();
    }
  }

  void loadLastSpinTime() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLastSpinTime = prefs.getString('lastSpinTime');
    if (savedLastSpinTime != null) {
      lastSpinTime = DateTime.parse(savedLastSpinTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg1,
        appBar: AppBar(
          backgroundColor: bg1,
          toolbarHeight: 60,
          elevation: 0.0,
          title: BigText(
            text: "Lucky Coins",
            weight: FontWeight.bold,
          ),
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
                                    "${_ctrl.points}",
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
                                  "${_controller.videoCoins}",
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
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(),
              SizedBox(
                height: Dimentions.height100 * 3 + Dimentions.height50,
                child: Stack(
                  children: [
                    FortuneWheel(
                      animateFirst: false,
                      selected: selected,
                      items: [
                        for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                          FortuneItem(
                              child: Row(
                            children: [
                              SizedBox(
                                width: Dimentions.width20 * 4 - 15,
                              ),
                              Image(
                                image:
                                    const AssetImage("assets/images/coin.png"),
                                height: Dimentions.height15 * 2,
                              ),
                              SizedBox(
                                width: Dimentions.width5,
                              ),
                              Text(
                                items[i].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimentions.font20 - 2),
                              ),
                            ],
                          ))
                        }
                      ],
                      onAnimationEnd: () {
                        setState(() {
                          rewards = items[selected.value];
                        });
                        _ctrl.points += rewards;
                        _controller.videoCoins += rewards;
                        _controller.saveVideoPoints();
                        _ctrl.savePoints();
                        _ctrl.showToast("Coins received");
                      },
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: onTapGoButton,
                        child: Container(
                          height: Dimentions.height100,
                          width: Dimentions.width100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            //goButtonColor,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(
                                  text: "GO",
                                  weight: FontWeight.bold,
                                ),
                                const Text(
                                  '40 Coins',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimentions.height20 + 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: 15,
                    color: Colors.red,
                  ),
                  MediumText(text: "Rules"),
                  Container(
                    height: 2,
                    width: 15,
                    color: Colors.red,
                  )
                ],
              ),
              SmallText(text: "-Eatch draw consumes 40 coins."),
              SmallText(text: "-Coins will be deduct from your both coins"),
              SmallText(text: "-Unlimited draws"),
              const Spacer(
                flex: 2,
              )
            ]),
          ),
        ));
  }
}
