import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/bottom_sheet_widget.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/dialog_widget.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:flutter_firebase_crud/global/internet_controller.dart';
import 'package:get/get.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;
  final HomeController homeController;
  final NetController netController;
  const TodoCardWidget(
      {Key? key,
      required this.todoModel,
      required this.homeController,
      required this.netController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoModel.complated ? myGreyColor : myWhiteColor,
      shadowColor: todoModel.complated ? Colors.transparent : null,
      child: Obx(() => ListTile(
            leading: Visibility(
              visible: netController.isOnline,
              child: Checkbox(
                side: BorderSide(color: myBlueColor, width: 2),
                activeColor: myBlueColor,
                value: todoModel.complated,
                onChanged: (status) {
                  FirestoreServices.updateTodoComplated(
                      status!, todoModel.documentId);
                },
              ),
            ),
            title: Text(todoModel.title,
                style: TextStyle(
                    decoration: todoModel.complated
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    overflow: TextOverflow.ellipsis)),
            subtitle: Text(todoModel.content,
                style: TextStyle(
                    decoration: todoModel.complated
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    overflow: TextOverflow.ellipsis)),
            isThreeLine: true,
            trailing: Visibility(
              visible: netController.isOnline,
              child: IconButton(
                  onPressed: () async => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogWidget(
                            context: Get.context,
                            title: "Delete Todo",
                            message:
                                "Are you sure to delete todo ?\n(${todoModel.title})",
                            docId: todoModel.documentId!,
                          );
                        },
                      ),
                  icon: const Icon(Icons.delete, color: myRedColor)),
            ),
            onTap: netController.isOnline
                ? () {
                    homeController.titleController.text = todoModel.title;
                    homeController.contentController.text = todoModel.content;
                    homeController.holdTitle.value = todoModel.title;
                    homeController.holdContent.value = todoModel.content;
                    homeController.changedDetect.value = "";

                    CustomBottomSheetWidget.showBSheet(
                        context: context,
                        text: 'UPDATE',
                        docId: todoModel.documentId,
                        controller: homeController);
                  }
                : null,
          )),
    );
  }
}
