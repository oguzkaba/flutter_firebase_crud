import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:get/get.dart';

class CustomSnackbarWidget {
  static void showSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: TextStyle(fontSize: 16, color: myWhiteColor.withOpacity(0.8)),
        ),
        messageText: Text(
          message,
          style: TextStyle(color: myWhiteColor.withOpacity(0.5)),
        ),
        colorText: myWhiteColor,
        borderRadius: 8,
        margin: EdgeInsets.all(16));
  }
}
