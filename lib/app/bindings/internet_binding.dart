import 'package:flutter_instagram/app/controllers/login_controller.dart';
import 'package:flutter_instagram/app/services/connectivity_service.dart';
import 'package:get/get.dart';

class ConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => Connectivity());
  }
}
