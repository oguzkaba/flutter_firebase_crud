import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class CustomBottomSheetWidget {
  static showBSheet(
      {required BuildContext? context,
      required String category,
      String? docId,
      required HomeController controller}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: myWhiteColor,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UPDATE Todo',
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
                                      color: myRedColor, fontSize: 16,fontWeight: FontWeight.bold)),
                            )))),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: Get.context!.width, height: 45),
                    child: ElevatedButton(
                        child: Text(
                          "UPDATE",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: myBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          controller.updateTodo(
                              controller.titleController.text,
                              controller.contentController.text,
                              docId!,
                              category);
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
