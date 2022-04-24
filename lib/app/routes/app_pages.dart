import 'package:get/get.dart';

import 'package:flutter_firebase_crud/app/modules/add_todo/bindings/add_todo_binding.dart';
import 'package:flutter_firebase_crud/app/modules/add_todo/views/add_todo_view.dart';
import 'package:flutter_firebase_crud/app/modules/history/bindings/history_binding.dart';
import 'package:flutter_firebase_crud/app/modules/history/views/history_view.dart';
import 'package:flutter_firebase_crud/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_firebase_crud/app/modules/home/views/home_view.dart';
import 'package:flutter_firebase_crud/app/modules/intro/bindings/intro_binding.dart';
import 'package:flutter_firebase_crud/app/modules/intro/views/intro_view.dart';
import 'package:flutter_firebase_crud/app/modules/main/bindings/main_binding.dart';
import 'package:flutter_firebase_crud/app/modules/main/views/main_view.dart';
import 'package:flutter_firebase_crud/app/modules/profile/bindings/profile_binding.dart';
import 'package:flutter_firebase_crud/app/modules/profile/views/profile_view.dart';
import 'package:flutter_firebase_crud/app/modules/reports/bindings/reports_binding.dart';
import 'package:flutter_firebase_crud/app/modules/reports/views/reports_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.INTRO;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TODO,
      page: () => AddTodoView(),
      binding: AddTodoBinding(),
    ),
  ];
}
