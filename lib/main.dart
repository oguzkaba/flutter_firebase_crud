import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/firebase_options.dart';
import 'package:flutter_firebase_crud/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_firebase_crud/app/themes/theme.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: fbOptions);
  HomeBinding().dependencies();
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: Themes.lightTheme()),
  );
}
