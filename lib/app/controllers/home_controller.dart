import 'package:flutter_instagram/app/screens/login_screen.dart';
import 'package:flutter_instagram/app/screens/post_screen.dart';
import 'package:flutter_instagram/app/screens/profile_screen.dart';
import 'package:flutter_instagram/app/screens/search_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  final box = GetStorage();
  bool authenticated = false;

  @override
  void onInit() {
    isAuthenticated();
    super.onInit();
  }

  /// check user is logged in or not.
  void isAuthenticated() {
    final token = box.read("access_token");
    if (token != null) {
      authenticated = true;
    }
  }

  List<Widget> lstScreens = [PostScreen(), SearchScreen(), ProfileScreen()];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
