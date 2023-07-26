import 'dart:convert';

import 'package:flutter_instagram/app/models/post_res_model.dart';
import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PostController extends GetxController {
  final api = APIHelper();
  final box = GetStorage();
  PostResModel posts = PostResModel();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  bool isLoading = false;
  void getAllPosts() async {
    isLoading = true;
    update();
    try {
      final token = box.read("access_token");
      print("token $token");
      final res = await api.getAllPost(token: token);
      print("All posts ${jsonEncode(res)}");
      posts = res;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
        "getAllPosts",
        e.toString(),
      );
    }
  }
}
