import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbarWidget {
  static void showSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.8)),
        ),
        messageText: Text(
          message,
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(16));
  }
}
