import 'dart:io';

import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:flutter_instagram/app/services/connectivity_service.dart';
import 'package:flutter_instagram/app/services/storage_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

import '../constant/constant.dart';

class AuthController extends GetxController {
  final _api = APIHelper();
  final _imagePicker = ImagePicker();
  File? photoProfile;
  void login({required String email, required String password}) async {
    try {
      final connected = await Connectivity.checkInternetConnection();
      if (!connected) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Please check your internet connection',
        );
        return;
      }
      final user = await _api.login(email: email, password: password);
      setToken(user.accessToken!);
      Get.offAllNamed("home");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  void setToken(String token) async {
    StorageHelper.write(kTokenKey, token);
  }

  void selectPhotoProfile() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        photoProfile = File(pickedFile.path);
        update();
        print("photo profile selected");
      } else {
        print("no photo profile selected");
      }
    } catch (e) {
      print(e);
    }
  }

  void register({
    required String name,
    required String email,
    required password,
    required File? profile,
  }) async {
    try {
      await _api.registerUser(
          name: name, email: email, profile: profile, password: password);
      Get.back(result: true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }
}
