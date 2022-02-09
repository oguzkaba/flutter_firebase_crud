import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/bottom_sheet_widget.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController, contentController;

  @override
  void onInit() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    super.onInit();
  }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return "Title can not be empty";
    }
    return null;
  }

  String? validateContent(String value) {
    if (value.isEmpty) {
      return "Content can not be empty";
    }
    return null;
  }

  void saveUpdateTodo(
      String title, String content, String docId, int addEditFlag) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      BottomSheetDialog.showDialog();
      FirestoreServices.addTodo(TodoModel(title: title, content: content))
          .then((value) {
        BottomSheetDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Todo Added",
            message: "Todo added successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        BottomSheetDialog.cancelDialog();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.redAccent);
      });
    } else if (addEditFlag == 2) {
      //TODO: update
      BottomSheetDialog.showDialog();
      FirestoreServices.updateTodo(false, docId).then(() {
        BottomSheetDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Employee Updated",
            message: "Employee updated successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        BottomSheetDialog.cancelDialog();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.red);
      });
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
