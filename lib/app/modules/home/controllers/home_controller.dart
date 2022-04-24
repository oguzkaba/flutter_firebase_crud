import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/remote/services/services.dart';
import 'package:flutter_firebase_crud/app/data/remote/models/todo_model.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/widgets/loading_widget.dart';
import 'package:flutter_firebase_crud/app/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance=Get.put(HomeController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController, contentController;
  final changedDetect = "".obs;
  final holdContent = "".obs;
  final holdTitle = "".obs;

  @override
  void onInit() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    super.onInit();
  }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return emptyTitleErrorText;
    }
    return null;
  }

  String? validateContent(String value) {
    if (value.isEmpty) {
      return emptyContentErrorText;
    }
    return null;
  }

  void updateTodo(
      String title, String content, String docId, String category) {
    final isValid = formKey.currentState!.validate();
    if (!isValid || title.isEmpty || content.isEmpty) {
      return;
    }
    formKey.currentState!.save();
    //UPDATE Operation
    if (title != holdTitle.value || content != holdContent.value) {
      LoadingWidget.showDialog();
      FirestoreServices.updateTodo(TodoModel(
              title: title,
              content: content,
              documentId: docId,
              category: category))
          .then((value) {
        LoadingWidget.cancelDialog();
        clearEditingControllers();
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        Get.back();
        CustomSnackbarWidget.showSnackBar(
          icon: Icon(Icons.check),
          context: Get.context!,
          title: "Todo Updated",
          message: "Todo updated successfully",
          backgroundColor: myGreenColor,
        );
      }).catchError((error) {
        LoadingWidget.cancelDialog();
        CustomSnackbarWidget.showSnackBar(
            icon: Icon(Icons.error),
            context: Get.context!,
            title: "Error",
            message: wrongText,
            backgroundColor: myRedColor);
      });
    } else {
      changedDetect.value = noChangeWarningText;
    }
  }

  void clearEditingControllers() {
    titleController.clear();
    contentController.clear();
  }
}
