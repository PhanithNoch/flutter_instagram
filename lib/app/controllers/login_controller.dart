import 'dart:convert';

import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final _api = APIHelper();
  final box = GetStorage();
  void login({required String email, required String password}) async {
    try {
      final user = await _api.login(email: email, password: password);
      setToken(user.accessToken!);
      Get.offAllNamed("home");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  void setToken(String token) async {
    await box.write("access_token", token);
  }
}
