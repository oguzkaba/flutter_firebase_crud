import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:get/get.dart';

class CustomDialogWidget {
  static void showDialogWidget(
      {required BuildContext? context,
      required String title,
      required String message,
      required String docId
      //required Color backgroundColor,
      }) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 20),
      middleText: message,
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () => Get.back(),
      onConfirm: () {
        FirestoreServices.deleteTodo(docId);
        Get.back();
      },
    );
  }
}
