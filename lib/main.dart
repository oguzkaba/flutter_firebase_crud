import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_crud/app/data/firebase_options.dart';
import 'package:flutter_firebase_crud/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_firebase_crud/app/themes/theme.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase initializeApp Web/Mobile
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(options: fbOptions);
  } else {
    await Firebase.initializeApp();
  }

  //Home Binding
  HomeBinding().dependencies();

  //orientation config
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo List",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: Themes.lightTheme()),
  );
}
