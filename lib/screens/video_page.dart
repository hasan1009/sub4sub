import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sub4subytbsrt/controllers/controllers.dart';
import 'package:sub4subytbsrt/controllers/video_page_controller.dart';
import 'package:sub4subytbsrt/utils/text/small_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import '../utils/text/big_text.dart';
import '../utils/text/medium_text.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int pageIndex = 0;
  final Controllers _ctrl = Get.put(Controllers());
  final VideoPageController _c = Get.put(VideoPageController());
  PageController pageController = PageController();
  Duration totalVideoDuration = const Duration(seconds: 0);

  // Create a list of YoutubePlayerControllers
  List<YoutubePlayerController?> _controllers = [];
  bool isPlaying = false;
  int elapsedTimeInSeconds = 0;
  int second = 1;
  double progressValue = 0.0;

  bool isVideoEnded = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the list of controllers
    _controllers = List.generate(
      _ctrl.videoviewLinks.length,
      (index) {
        final videoId =
            YoutubePlayer.convertUrlToId(_ctrl.videoviewLinks[index]);

        if (videoId != null && videoId.isNotEmpty) {
          return YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
          )..addListener(() {
              if (_controllers[pageIndex]!.value.isPlaying) {
                if (!isPlaying) {
                  startTimer();
                  setState(() {
                    isPlaying = true;
                    isVideoEnded = false;
                  });
                }
              } else {
                setState(() {
                  isPlaying = false;
                  stopTimer();
                  if (_controllers[pageIndex]!.value.position ==
                      _controllers[pageIndex]!.metadata.duration) {
                    isVideoEnded = true;
                  }
                });
              }
            });
        } else {
          _ctrl.showToast("Invalid video Link");
          return null;
        }
      },
    );
  }

  void startTimer() {
    if (_timer == null || !_timer!.isActive) {
      Duration interval = Duration(seconds: second);
      _timer = Timer.periodic(interval, (Timer timer) {
        if (_controllers[pageIndex]!.value.isPlaying) {
          setState(() {
            elapsedTimeInSeconds++;
            progressValue = elapsedTimeInSeconds / 120;
            if (elapsedTimeInSeconds >= 120) {
              _c.increaseVideoPoints();
              _c.saveVideoPoints();
              _ctrl.showToast("You've earned 10 coins");
              elapsedTimeInSeconds = 0;
              progressValue = 0.0;

              onNextVideoPressed();
              _ctrl.updateGetvideo();
            }
          });
        }
      });
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void onNextVideoPressed() {
    setState(() {
      if (pageIndex < _ctrl.videoviewLinks.length - 1) {
        pageIndex++;
      } else {
        _ctrl.showToast("All video is finished");
        isVideoEnded = true;
      }

      elapsedTimeInSeconds = 0;
    });

    // Check if all videos are finished, and display Lottie asset
    if (isVideoEnded) {
      // Stop the video player (if any)
      if (_controllers[pageIndex] != null) {
        _controllers[pageIndex]!.pause();
      }
    } else {
      // If not finished, continue playing the next video
      _controllers[pageIndex]!.play();
    }
  }

  /*void onNextVideoPressed() {
    setState(() {
      if (pageIndex < _ctrl.videoviewLinks.length - 1) {
        pageIndex++;

        elapsedTimeInSeconds = 0;
        isVideoEnded = false;
      } else {
        _ctrl.showToast("All video is finished");
        isVideoEnded = true;
      }
    });

    /* if (!isVideoEnded) {
      pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }*/
  }*/

  void onPausePressed() {
    setState(() {
      isPlaying = false;
    });
    _controllers[pageIndex]!.pause();
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
    for (var controller in _controllers) {
      controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      appBar: AppBar(
        title: BigText(
          text: "Video",
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
                    Lottie.asset("assets/lottie/videocoin.json",
                        height: 40,
                        repeat: true,
                        reverse: true,
                        fit: BoxFit.cover),
                    SizedBox(
                      width: Dimentions.width5 - 3,
                    ),
                    Obx(
                      () => Text(
                        "${_c.videoCoins}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimentions.font20 - 2,
                        ),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimentions.height100 * 2 + 70,
              child: PageView.builder(
                controller: pageController,
                itemCount: _ctrl.videoviewLinks.length,
                itemBuilder: (context, index) {
                  if (index < _ctrl.videoviewLinks.length) {
                    if (_ctrl.videoviewLinks.isNotEmpty) {
                      return YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controllers[index]!,
                          showVideoProgressIndicator: true,
                        ),
                        builder: (context, player) {
                          return Column(
                            children: [
                              player,
                            ],
                          );
                        },
                      );
                    } else {
                      // If you want to show something else for videos that are not yet loaded
                      return CircularProgressIndicator(); // You can change this to any other widget
                    }
                  } else if (index == _ctrl.videoviewLinks.length &&
                      isVideoEnded) {
                    // Display Lottie asset on the last page when all videos are finished
                    return Lottie.asset("assets/lottie/giftbox.json");
                  } else {
                    return Container(); // Empty container for other cases
                  }
                },
                onPageChanged: (index) => setState(() {
                  pageIndex = index;
                  elapsedTimeInSeconds = 0;
                  isVideoEnded = false;
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimentions.width15),
              margin: EdgeInsets.symmetric(
                  horizontal: Dimentions.width10,
                  vertical: Dimentions.height20),
              decoration: BoxDecoration(
                  color: bg3,
                  borderRadius: BorderRadius.circular(Dimentions.radius20)),
              child: Column(
                children: [
                  Text("Earn points by watching videos :3"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: const Color(0xFF3F4768), width: 3)),
                      child: Stack(
                        children: [
                          LayoutBuilder(builder: (context, constraints) {
                            return Container(
                              width: constraints.maxWidth * progressValue,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: const LinearGradient(
                                      colors: [Colors.red, Colors.white])),
                            );
                          }),
                          Positioned.fill(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${(120 - elapsedTimeInSeconds).toString()} sec",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Lottie.asset(
                                  "assets/lottie/videocoin.json",
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => onPausePressed(),
                        icon: const Icon(Icons.pause),
                        label: const Text('Pause'),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: followButton),
                        onPressed: () {
                          if (!_controllers[pageIndex]!.value.isPlaying) {
                            _controllers[pageIndex]!.play();
                          }
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => onNextVideoPressed(),
                        label: const Text('Next'),
                        icon: const Icon(Icons.skip_next),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimentions.height10,
              ),
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
                          height: Dimentions.height20 * 2, fit: BoxFit.cover),
                      MediumText(text: "Tips"),
                    ],
                  ),
                  SizedBox(height: Dimentions.height10 / 2),
                  SmallText(
                    text:
                        "1. Click the play button   2. Watch the video    \n3. Get 10 coins after every 2 minutes",
                    color: Colors.white54,
                  ),
                  SizedBox(
                    height: Dimentions.height20 + 5,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
