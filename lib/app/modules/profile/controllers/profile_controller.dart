import 'package:flutter_firebase_crud/app/data/local/local_storage_controller.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController {
  static ProfileController instance=Get.put(ProfileController());

  final _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  ).obs;

  final loadingAppInfo = true.obs;

  PackageInfo get packageInfo => _packageInfo.value;

  @override
  void onInit() {
    _initPackageInfo();
    super.onInit();
  }

  Future<void> _initPackageInfo() async {
    loadingAppInfo.value = true;
    final info = await PackageInfo.fromPlatform();
    _packageInfo.value = info;
    loadingAppInfo.value = false;
  }

  void changeTheme() {
    LocalStorageController.instance.changeThemeMode();
  }
}
