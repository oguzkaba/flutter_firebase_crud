import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:get/get.dart';

class CustomDialogWidget extends StatelessWidget {
  final BuildContext? context;
  final String title;
  final String message;
  final VoidCallback onPress;

  const CustomDialogWidget({
    Key? key,
    this.context,
    required this.title,
    required this.message,
    required this.onPress
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(width: 1, color: myRedColor),
          ),
          child: Text('Cancel', style: TextStyle(color: myRedColor)),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: myRedColor),
          child: Text('Delete', style: TextStyle(color: myWhiteColor)),
          onPressed: onPress
        ),
      ],
    );
  }
}
