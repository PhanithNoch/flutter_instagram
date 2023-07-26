import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/bindings/home_binding.dart';
import 'package:flutter_instagram/app/bindings/login_binding.dart';
import 'package:flutter_instagram/app/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/screens/login_screen.dart';
import 'app/screens/register_screen.dart';

void main() async {
  await GetStorage.init();

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "home",
      // initialBinding: LoginBinding(),
      getPages: [
        GetPage(
          name: "/login",
          page: () => LoginScreen(),
        ),
        GetPage(name: "/register", page: () => RegisterScreen()),
        GetPage(
            name: "/home", page: () => HomeScreen(), binding: HomeBinding()),
      ],
    );
  }
}
