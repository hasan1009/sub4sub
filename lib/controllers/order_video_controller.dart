import 'package:get/get.dart';
import 'package:sub4subytbsrt/repository/order_video_repo.dart';

import '../models/video_campaign_model.dart';

class OrderVideoController extends GetxController {
  static OrderVideoController get instance => Get.find();

  final orderVideoRepo = Get.put(OrderVideoRepo());

  Future<void> orderVideo(VideoCampaignModel videoCampaignModel) async {
    await orderVideoRepo.orderVideo(videoCampaignModel);
  }
}
