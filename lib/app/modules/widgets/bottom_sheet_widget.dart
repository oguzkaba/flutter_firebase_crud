import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
