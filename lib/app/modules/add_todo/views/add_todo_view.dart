import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/add_todo_controller.dart';

class AddTodoView extends GetView<AddTodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => Text(
              NetController.instance.isOnline
                  ? "Todo List - Add TODO"
                  : "Todo List (Offline) ",
              style: TextStyle(fontSize: 20),
            )),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: _formBuild(AddTodoController.instance, context),
      ),
    );
  }

  Form _formBuild(AddTodoController controller, BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Todo',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: myBlueColor),
            ),
            SizedBox(height: 18),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: controller.titleController,
              validator: (value) => controller.validateTitle(value!),
            ),
            SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: controller.contentController,
              validator: (value) => controller.validateContent(value!),
            ),
            Obx(() => Container(
                child: controller.changedDetect.isEmpty
                    ? SizedBox(height: 10)
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(controller.changedDetect.value,
                            style: TextStyle(
                                color: myRedColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      )))),
            SizedBox(height: 20),
            _addCategories(controller),
            SizedBox(height: 20),
            _addPhoto(controller, context),
            SizedBox(height: 40),
            _saveButton(controller)
          ],
        ),
      ),
    );
  }

  ConstrainedBox _saveButton(AddTodoController controller) {
    return ConstrainedBox(
      constraints:
          BoxConstraints.tightFor(width: Get.context!.width, height: 45),
      child: ElevatedButton(
          child: Text(
            "Add",
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: myBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            controller.saveTodo(controller.titleController.text,
                controller.contentController.text, controller.category.value);
          }),
    );
  }

  Obx _addPhoto(AddTodoController controller, BuildContext context) {
    return Obx(() => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                    width: Get.width / 2,
                    height: Get.height / 4,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: myBlueColor),
                    ),
                    child: controller.imageFileList!.isEmpty
                        ? SizedBox.shrink()
                        : Image.file(File(controller.imageFileList!.last.path),
                            fit: BoxFit.cover)),
              ),
              Expanded(
                flex: 3,
                child: IconButton(
                    onPressed: () => controller.openSelectedPicker(
                        context, ImageSource.gallery),
                    icon: Icon(Icons.add_a_photo_rounded, size: 50)),
              ),
            ],
          ),
        ));
  }

  Obx _addCategories(AddTodoController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Categories"),
            DropdownButton(
                key: UniqueKey(),
                value: controller.category.value,
                items: todoCategories
                    .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 25),
                        )))
                    .toList(),
                onChanged: ((Object? newValue) =>
                    controller.category.value = newValue as String)),
          ],
        ));
  }
}
