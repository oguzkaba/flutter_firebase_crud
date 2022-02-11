import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/loading_widget.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/snackbar_widget.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
  }

  String? validateContent(String value) {
    if (value.isEmpty) {
      return emptyContentErrorText;
    }
  }

  void saveUpdateTodo(
      String title, String content, String docId, String operation) {
    final isValid = formKey.currentState!.validate();
    if (!isValid || title.isEmpty || content.isEmpty) {
      return;
    }
    formKey.currentState!.save();
    //ADD Operation
    if (operation == "ADD") {
      LoadingWidget.showDialog();
      FirestoreServices.addTodo(TodoModel(title: title, content: content))
          .then((value) async {
        LoadingWidget.cancelDialog();
        clearEditingControllers();
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        Get.back();

        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Added",
            message: "Todo added successfully",
            backgroundColor: myGreenColor);
      }).catchError((error) {
        LoadingWidget.cancelDialog();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Error",
            message: wrongText,
            backgroundColor: myRedColor);
      });
    }
    //UPDATE Operation
    else if (operation == "UPDATE" &&
        (title != holdTitle.value || content != holdContent.value)) {
      LoadingWidget.showDialog();
      FirestoreServices.updateTodo(
              TodoModel(title: title, content: content, documentId: docId))
          .then((value) {
        LoadingWidget.cancelDialog();
        clearEditingControllers();
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        Get.back();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Todo Updated",
            message: "Todo updated successfully",
            backgroundColor: myGreenColor);
      }).catchError((error) {
        LoadingWidget.cancelDialog();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Error",
            message: wrongText,
            backgroundColor: myRedColor);
      });
    } else {
      changedDetect.value = noChangeWarningText;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
  }

  void clearEditingControllers() {
    titleController.clear();
    contentController.clear();
  }
}
