import 'package:flutter_instagram/app/services/storage_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (StorageHelper.read('access_token') == null) {
      return const RouteSettings(name: '/login');
    }

    return null;
  }
}
