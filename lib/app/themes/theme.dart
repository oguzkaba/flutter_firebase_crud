import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
class Themes {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          backgroundColor: myWhiteColor,
          titleTextStyle: TextStyle(
              color: myBlueColor, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith();
  }
}
