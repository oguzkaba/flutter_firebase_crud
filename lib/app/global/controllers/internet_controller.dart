// ignore: unused_import
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

class NetController extends GetxController {
  static NetController instance=Get.put(NetController());
  final Connectivity _connectivity = Connectivity();
  final _isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    startMonitoring();
  }

  bool get isOnline => _isOnline.value;

  Future<bool?> startMonitoring() async {
    _connectivity.onConnectivityChanged.listen((
      result,
    ) async {
      if (result == ConnectivityResult.none) {
        _isOnline.value = false;
        netErrorSnackBar();
      } else {
        await _updateConnectionStatus().then((isConnected) {
          _isOnline.value = isConnected!;
        });
      }
    });
    return null;
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        _isOnline.value = false;
        netErrorSnackBar();
      } else {
        _isOnline.value = true;
      }
    } on PlatformException catch (e) {
      print("PlatformException: $e");
    }
  }

  Future<bool?> _updateConnectionStatus() async {
    bool? isConnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
        Get.back();
      }
    } on SocketException catch (_) {
      isConnected = false;
      netErrorSnackBar();
    }
    return isConnected;
  }
}

int d = 0;
netErrorSnackBar() {
  d += 1;
  if (NetController().isOnline == false && d == 1) {
    CustomSnackbarWidget.showSnackBar(
      title: "WARNING..!",
      context: Get.context!,
      message:
          'You are not connected to the internet.\n Make sure Wi-Fi is or Mobile Data on, Airplane Mode is Off and try again.',
      backgroundColor: myRedColor,
      icon: Icon(Icons.wifi_off_rounded, color: myWhiteColor),
    );
    d = 0;
  }
}
