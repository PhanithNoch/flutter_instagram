import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/constant/constant.dart';
import 'package:flutter_instagram/app/screens/edit_profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_instagram/app/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ProfileController>(builder: (context) {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("$displayProfile/${controller.currentUser.profileUrl}");
              return Stack(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        "$displayProfile/${controller.currentUser.profileUrl}"),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 1.0,
                    child: GestureDetector(
                      onTap: () {
                        print("pressed");
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              width: Get.width * 0.06,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.currentUser.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "${controller.currentUser.email}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                /// add edit button
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(
                      () => EditProfileScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.05,
        ),
        Divider(
          thickness: 1.0,
        ),
        Spacer(),
        ListTile(
          onTap: () {
            controller.logout();
          },
          leading: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      ],
    ));
  }
}
