import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';
import 'package:get/get.dart';

class NoEntryWidget extends StatelessWidget {
  const NoEntryWidget({
    Key? key,
    required this.netContoller,
  }) : super(key: key);

  final NetController netContoller;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
      Icon(Icons.event_busy,
          color: myRedColor.withOpacity(0.05), size: Get.width),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
            netContoller.isOnline ? noEntryOnlineText : noEntryOfflineText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18)),
      ),
    ]));
  }
}



