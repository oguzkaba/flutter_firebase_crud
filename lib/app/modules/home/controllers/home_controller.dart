import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/loading_widget.dart';
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
  }

  String? validateContent(String value) {
    if (value.isEmpty) {
      return "Content can not be empty";
    }
  }

  void saveUpdateTodo(
      String title, String content, TodoModel todoModel, String operation) {
    final isValid = formKey.currentState!.validate();
    if (!isValid || title.isEmpty || content.isEmpty) {
      return;
    }
    formKey.currentState!.save();
    if (operation == "ADD") {
      LoadingWidget.showDialog();
      FirestoreServices.addTodo(TodoModel(title: title, content: content))
          .then((value) {
        LoadingWidget.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Added",
            message: "Todo added successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        LoadingWidget.cancelDialog();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.redAccent);
      });
    } else if (operation == "UPDATE") {
      // TO-DO: update
      LoadingWidget.showDialog();
      FirestoreServices.updateTodo(todoModel).then(() {
        LoadingWidget.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackbarWidget.showSnackBar(
            context: Get.context,
            title: "Todo Updated",
            message: "Todo updated successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        LoadingWidget.cancelDialog();
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
