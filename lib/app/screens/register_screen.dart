import 'package:flutter_instagram/app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register";
  RegisterScreen({super.key});
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final nameCon = TextEditingController();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,

          /// add gradient background

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Spacer(),

                  /// add widget to select photo profile from gallery.
                  GetBuilder<AuthController>(builder: (context) {
                    if (controller.photoProfile != null) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: Get.height * 0.2,
                            width: Get.width * 0.3,
                            child: GestureDetector(
                              onTap: () {
                                controller.selectPhotoProfile();

                                // print("select photo profile");
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    FileImage(controller.photoProfile!),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 30,
                            child: GestureDetector(
                              onTap: () {
                                controller.selectPhotoProfile();

                                // print("select photo profile");
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.3,
                      child: GestureDetector(
                        onTap: () {
                          controller.selectPhotoProfile();

                          print("select photo profile");
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    );
                  }),

                  // SizedBox(height: Get.height * 0.08),

                  TextFormField(
                    controller: emailCon,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!GetUtils.isEmail(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: Get.height * 0.02),

                  /// add name textformfield
                  TextFormField(
                    controller: nameCon,
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  TextFormField(
                    obscureText: true,
                    controller: passwordCon,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            String name = nameCon.text;
                            String email = emailCon.text;
                            String password = passwordCon.text;
                            if (_formKey.currentState!.validate()) {
                              controller.register(
                                name: name,
                                email: email,
                                password: password,
                                profile: controller.photoProfile,
                              );
                            }
                          },
                          child: const Text("Register"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),

                  /// add divider and or text center

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),
                      Text("OR"),
                      Expanded(
                        child: Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  /// add register text button
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Back to Login"),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
