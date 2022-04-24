import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/local/local_storage_controller.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
                NetController.instance.isOnline?
          'Todo List - Profile':'Todo List - Profile (Offline)',
          style: TextStyle(fontSize: 20),
        )),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appSettings(
                  LocalStorageController.instance, ProfileController.instance),
              Divider(),
              _connectionStatus(),
              Divider(),
              _appInfo(ProfileController.instance),
            ],
          ),
        ),
      ),
    );
  }

  Obx _connectionStatus() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(28.0),
      child: _customListTile(
                'Internet Connection',
                NetController.instance.isOnline
                    ? 'You have internet connection'
                    : 'You do not have an internet connection',
                leadingIcon: NetController.instance.isOnline
                    ? Icons.wifi
                    : Icons.wifi_off_outlined,
                color: NetController.instance.isOnline
                    ? myGreenColor
                    : myRedColor),
    ));
  }

  Obx _appSettings(LocalStorageController localStorageController,
      ProfileController controller) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Text(
              "App Settings",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SwitchListTile.adaptive(
                secondary: localStorageController.darkTheme
                    ? Icon(Icons.brightness_2)
                    : Icon(Icons.wb_sunny, color: Colors.amber),
                title: Text('Change Theme'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(localStorageController.darkTheme
                    ? 'Dark Theme Enabled'.tr
                    : 'Light Theme Enabled'.tr),
                value: localStorageController.darkTheme,
                onChanged: (value) {
                  controller.changeTheme();
                  localStorageController.darkTheme =
                      !localStorageController.darkTheme;
                }),
          ],
        ),
      ),
    );
  }

  Obx _appInfo(ProfileController controller) {
    return Obx(() => controller.loadingAppInfo.value
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.fromLTRB(28,28,28,70),
            child: Column(
              children: [
                Text(
                  "App Info",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                _customListTile('App name', controller.packageInfo.appName),
                _customListTile(
                    'Package name', controller.packageInfo.packageName),
                _customListTile('App version', controller.packageInfo.version),
                _customListTile(
                    'Build number', controller.packageInfo.buildNumber),
                _customListTile(
                    'Build signature', controller.packageInfo.buildSignature),
              ],
            ),
          ));
  }
}

Widget _customListTile(String title, String subtitle,
    {IconData? leadingIcon, Color? color}) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: Icon(leadingIcon ?? Icons.check, color: color),
  );
}
