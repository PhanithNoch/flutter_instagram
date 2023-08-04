import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Connectivity extends GetxService {
  @override
  void onInit() {
    super.onInit();
  }

  static Future<bool> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
    if (result == true) {
      print('YAY! Free cute dog pics!');
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      );
    } else {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      );
      print('No internet :( Reason:');
      // print(InternetConnectionChecker().lastTryResults);
    }
  }
}
