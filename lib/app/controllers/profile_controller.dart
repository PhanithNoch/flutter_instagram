import 'dart:convert';

import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_res_profile_model.dart';

class ProfileController extends GetxController {
  final _api = APIHelper();
  final box = GetStorage();
  bool isLoading = false;
  UserProfileResModel currentUser = UserProfileResModel();

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }

  // var currentUser = {
  //   "email": "jonhdoe@gmail.com",
  //   "name": "John Doe",
  //   "profile_url":
  //       "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80"
  // };
  void logout() async {
    try {
      final access_token = box.read("access_token");
      print("access token $access_token");
      final message = await _api.logout(accessToken: access_token);
      box.remove("access_token");

      Get.snackbar("Message", message,
          duration: Duration(milliseconds: 500), backgroundColor: Colors.green);
      Get.offAllNamed("login");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  void getCurrentUser() async {
    try {
      isLoading = true;
      update();
      final accessToken = box.read("access_token");

      final res = await _api.getCurrentUser(token: accessToken);
      print("user ${jsonEncode(res)}");
      currentUser = res;
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
        "getCurrentUser",
        e.toString(),
      );
    }
  }
}
