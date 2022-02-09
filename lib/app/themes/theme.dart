import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:flutter_firebase_crud/global/internet_controller.dart';
import 'package:get/get.dart';

class Themes {
  static ThemeData lightTheme() {
    final NetController netContoller = Get.put(NetController());

    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: netContoller.isOnline ? myBlueColor : Colors.grey,
          ),
          backgroundColor: myWhiteColor,
          titleTextStyle: TextStyle(
              color: myBlueColor, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith();
  }
}
