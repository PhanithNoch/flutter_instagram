import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/controllers/home_controller.dart';
import 'package:flutter_instagram/app/controllers/post_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  HomeScreen({super.key});
  final postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return IndexedStack(
            index: controller.currentIndex,
            children: controller.lstScreens,
          );
        },
      ),
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
