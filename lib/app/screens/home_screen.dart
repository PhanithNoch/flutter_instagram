import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/controllers/home_controller.dart';
import 'package:flutter_instagram/app/controllers/post_controller.dart';
import 'package:flutter_instagram/app/screens/login_screen.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(ProfileController());
  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Feeds"),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        if (controller.authenticated == false) {
          return LoginScreen();
        }
        return IndexedStack(
          index: controller.currentIndex,
          children: controller.lstScreens,
        );
      }),
      bottomNavigationBar: GetBuilder<HomeController>(builder: (controller) {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) {
            controller.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        );
      }),
    );
  }
}
