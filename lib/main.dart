import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/services/storage_helper.dart';
import 'package:flutter_instagram/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      initialBinding: BindingsBuilder(() {
        Get.put(StorageHelper(), permanent: true);
      }),
      getPages: AppRoutes.lstPages,
    );
  }
}
