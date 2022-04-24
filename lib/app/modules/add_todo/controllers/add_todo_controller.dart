import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/remote/models/todo_model.dart';
import 'package:flutter_firebase_crud/app/data/remote/services/services.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/widgets/loading_widget.dart';
import 'package:flutter_firebase_crud/app/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddTodoController extends GetxController {
  static AddTodoController instance=Get.put(AddTodoController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController, contentController;
  final isSelected = false.obs;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = <XFile>[].obs;
  final changedDetect = "".obs;
  final holdContent = "".obs;
  final holdTitle = "".obs;
  final category = "Other".obs;
  final imageURL = "".obs;

  @override
  void onInit() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    super.onInit();
  }

  void openSelectedPicker(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      Get.back();
      if (pickedFile != null) {
        isSelected.value = true;
        imageFileList?.clear();
        imageFileList?.add(pickedFile);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    final _firebaseStorage = FirebaseStorage.instance;
    var file = File(imageFileList!.last.path);
    var firebaseStorageRef = _firebaseStorage.ref().child('uploads/$file');

    UploadTask uploadTask = firebaseStorageRef.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then(
          (value) => imageURL.value = value,
        );
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

  void saveTodo(String title, String content, String? category)async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || title.isEmpty || content.isEmpty) {
      return;
    }
    formKey.currentState!.save();
    //ADD Operation

    LoadingWidget.showDialog();
    await uploadImageToFirebase(Get.context!);
    FirestoreServices.addTodo(TodoModel(
            title: title,
            content: content,
            category: category ?? "Other",
            imageFileURL: imageURL.value))
        .then((value) async {
      LoadingWidget.cancelDialog();
      clearEditingControllers();
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      Get.back();

      CustomSnackbarWidget.showSnackBar(
          icon: Icon(Icons.check),
          context: Get.context!,
          title: "Added",
          message: "Todo added successfully",
          backgroundColor: myGreenColor);
    }).catchError((error) {
      LoadingWidget.cancelDialog();
      CustomSnackbarWidget.showSnackBar(
          icon: Icon(Icons.error),
          context: Get.context!,
          title: "Error",
          message: wrongText,
          backgroundColor: myRedColor);
    });
  }

  void clearEditingControllers() {
    imageFileList?.clear();
    titleController.clear();
    contentController.clear();
    category.value="Other";
  }
}
