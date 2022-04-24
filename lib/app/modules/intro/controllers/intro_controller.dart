import 'package:flutter_firebase_crud/app/data/local/local_storage_controller.dart';
import 'package:flutter_firebase_crud/app/routes/app_pages.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  void completeIntro() {
    LocalStorageController.instance.saveToPrefs();
    Get.offAllNamed(Routes.MAIN);
  }
}
