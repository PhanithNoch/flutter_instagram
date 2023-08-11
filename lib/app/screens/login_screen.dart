import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/controllers/login_controller.dart';
import 'package:flutter_instagram/app/screens/register_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailCon = TextEditingController(text: "apple@gmail.com");
  final passwordCon = TextEditingController(text: "123123");
  final _controller = Get.put(LoginController());

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
                  // SizedBox(height: Get.height * 0.1),
                  Text(
                    "WELCOME TO LOGIN SCREEN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(height: Get.height * 0.08),
                  TextFormField(
                    controller: emailCon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      if (!GetUtils.isEmail(value)) {
                        return "Email is not valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  TextFormField(
                    controller: passwordCon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
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
                            if (_formKey.currentState!.validate()) {
                              print("login");
                              _controller.login(
                                  email: emailCon.text,
                                  password: passwordCon.text);
                            }
                          },
                          child: Text("Login"),
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
                    onPressed: () async {
                      final status = await Get.to(() => RegisterScreen());
                      if (status == true) {
                        Get.snackbar("Success", "Register Success");
                      }
                    },
                    child: Text("Register"),
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
