import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterController extends GetxController {
  final _imagePicker = ImagePicker();
  File? photoProfile;
  final _helper = APIHelper();

  /// create a method to select photo profile from gallery.

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
      final res = await _helper.registerUser(
          name: name, email: email, profile: profile, password: password);
      Get.back(result: true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }
}
