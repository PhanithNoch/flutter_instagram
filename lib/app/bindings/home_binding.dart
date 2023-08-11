import 'package:flutter_instagram/app/controllers/home_controller.dart';
import 'package:flutter_instagram/app/controllers/post_controller.dart';
import 'package:flutter_instagram/app/controllers/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
    Get.lazyPut(
      () => PostController(),
    );
    Get.lazyPut(
      () => ProfileController(),
    );
  }
}
