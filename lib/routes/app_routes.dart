import 'package:flutter_instagram/app/bindings/home_binding.dart';
import 'package:flutter_instagram/app/middleware/login_middleware.dart';
import 'package:flutter_instagram/app/screens/home_screen.dart';
import 'package:flutter_instagram/app/screens/login_screen.dart';
import 'package:flutter_instagram/app/screens/register_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> lstPages = [
    GetPage(
      name: LoginScreen.routeName,
      page: () => LoginScreen(),
    ),
    GetPage(name: RegisterScreen.routeName, page: () => RegisterScreen()),
    GetPage(
      name: HomeScreen.routeName,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      middlewares: [
        LoginMiddleware(),
      ],
    ),
  ];
}
