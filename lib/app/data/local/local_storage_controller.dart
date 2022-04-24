import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageController extends GetxController {
  static LocalStorageController instance=Get.put(LocalStorageController());
  final _box = GetStorage();
  final _boxKey = "firstLogin";
  final firstLogin = false.obs;
  final _themeKey = 'isDarkmode';
  final _darkTheme = false.obs;

  @override
  Future<void> onInit() async {
    if (_box.read(_boxKey) != null) {
      await _loadFromPrefs();
      print('İlk gelen token: ${_box.read(_boxKey)}');
    }
    if (_box.read(_themeKey) != null) {
      _darkTheme.value = _box.read(_themeKey) as bool;
    }
    super.onInit();
  }

  String getRoute() {
    return _isFirstLogin() ? Routes.MAIN : Routes.INTRO;
  }

  bool _isFirstLogin() {
    return _box.read(_boxKey) ?? false;
  }

  _initPrefs() async {
    await GetStorage.init();
  }

  saveToPrefs() async {
    await _initPrefs();
    _box.write(_boxKey, true);
  }

  _loadFromPrefs() async {
    firstLogin.value = _box.read(_boxKey) as bool;
    await _initPrefs();
  }

  deleteFromPrefs() async {
    await _initPrefs();
    _box.remove(_boxKey);
  }

  bool get darkTheme => _darkTheme.value;
  set darkTheme(bool value) => _darkTheme.value = value;

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return _box.read(_themeKey) ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    _box.write(_themeKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }
}
