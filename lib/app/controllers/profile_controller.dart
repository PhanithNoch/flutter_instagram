import 'dart:convert';

import 'package:flutter_instagram/app/constant/constant.dart';
import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:flutter_instagram/app/services/storage_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_res_profile_model.dart';

class ProfileController extends GetxController {
  final _api = APIHelper();
  final box = GetStorage();
  bool isLoading = false;
  UserProfileResModel currentUser = UserProfileResModel();

  void logout() async {
    try {
      final token = StorageHelper.read(kTokenKey);
      await _api.logout(accessToken: token);
      StorageHelper.erase();

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
      Get.offAllNamed("login");
    }
  }
}
