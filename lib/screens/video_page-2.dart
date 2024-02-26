import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/video_page_controller.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import '../utils/text/big_text.dart';
import '../utils/text/medium_text.dart';
import '../utils/text/small_text.dart';

class VideoPage2 extends StatefulWidget {
  final List<String> videoLinks;
  const VideoPage2({super.key, required this.videoLinks});

  @override
  State<VideoPage2> createState() => _VideoPage2State();
}

class _VideoPage2State extends State<VideoPage2> {
  final VideoPageController videoPageController =
      Get.put(VideoPageController());
  late YoutubePlayerController _youtubePlayerController;

  //========================variable==========================
  int elapsedTimeInSeconds = 0;
  double progressValue = 0.0;
  int currentIndex = 0;
  bool showLottie = false;
  //========================timer==========================

  Timer? _timer;
  //========================timer==========================

  @override
  void initState() {
    if (widget.videoLinks.isNotEmpty &&
        currentIndex < widget.videoLinks.length) {
      final videoId =
          YoutubePlayer.convertUrlToId(widget.videoLinks[currentIndex]);

      setState(() {
        _youtubePlayerController = YoutubePlayerController(
            initialVideoId: videoId ?? "",
            flags: const YoutubePlayerFlags(autoPlay: true))
          ..addListener(() {
            if (_youtubePlayerController.value.isPlaying) {
              startTimer();
            } else {
              stopTimer();
            }
          });
      });
    } else {
      setState(() {
        _youtubePlayerController.pause();
        stopTimer();
      });
      print("Video List is empty");
    }

    super.initState();
  }

  void startTimer() {
    if (_timer == null || !_timer!.isActive) {
      Duration interval = const Duration(seconds: 1);
      _timer = Timer.periodic(interval, (Timer timer) {
        if (_youtubePlayerController.value.isPlaying) {
          setState(() {
            elapsedTimeInSeconds++;
            progressValue = elapsedTimeInSeconds / 120;
          });

          if (elapsedTimeInSeconds >= 120) {
            elapsedTimeInSeconds = 0;
            progressValue = 0.0;
            nextVideo();
            videoPageController.increaseVideoPoints();
            videoPageController.saveVideoPoints();
          }
        } else if (showLottie == true) {
          // Reset the timer when showLottie is true
          stopTimer();
          elapsedTimeInSeconds = 0;
          progressValue = 0.0;
        }
      });
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void nextVideo() {
    if (widget.videoLinks.isNotEmpty) {
      if (currentIndex <= widget.videoLinks.length - 1) {
        elapsedTimeInSeconds = 0;
        progressValue = 0.0;
        currentIndex++;
        final videoId =
            YoutubePlayer.convertUrlToId(widget.videoLinks[currentIndex]);
        if (videoId != null) {
          _youtubePlayerController.load(videoId);
          _youtubePlayerController.play();
        }
      } else {
        showLottie = true;
        stopTimer();
        elapsedTimeInSeconds = 0;
        progressValue = 0.0;
        print("No more videos to play.");
      }
    } else {
      print("Video List is empty");
    }
  }

  @override
  void dispose() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _youtubePlayerController.dispose();
    super.dispose();
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
                        "${videoPageController.videoCoins}",
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
              width: double.infinity,
              height: Dimentions.height150 + 100,
              child: showLottie
                  ? Center(child: Lottie.asset('assets/lottie/giftbox.json'))
                  : YoutubePlayer(
                      controller: _youtubePlayerController,
                      showVideoProgressIndicator: false,
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
                  Text(
                    "Earn points by watching videos :",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimentions.font20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Dimentions.height20),
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
                        onPressed: () {
                          _youtubePlayerController.pause();
                        },
                        icon: const Icon(Icons.pause),
                        label: const Text('Pause'),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: followButton),
                        onPressed: () {
                          _youtubePlayerController.play();
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play'),
                      ),
                      ElevatedButton.icon(
                        onPressed: nextVideo,
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
