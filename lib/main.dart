import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_crud/app/data/local/local_storage_controller.dart';
import 'package:flutter_firebase_crud/app/data/remote/configs/firebase_options.dart';
import 'package:flutter_firebase_crud/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_firebase_crud/app/themes/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Local Storage/Cached
  await GetStorage.init();

  //Firebase initializeApp Web/Mobile
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(options: fbOptions);
  } else {
    await Firebase.initializeApp();
  }

  //Home Binding
  HomeBinding().dependencies();

  //orientation config
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Todo List",
    initialRoute: LocalStorageController.instance.getRoute(),
    getPages: AppPages.routes,
    theme: Themes.lightTheme(),
    darkTheme: Themes.darkTheme(),
    themeMode: LocalStorageController.instance.getThemeMode(),
  ));
}
