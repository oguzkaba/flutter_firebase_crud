import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/remote/services/services.dart';
import 'package:flutter_firebase_crud/app/data/remote/models/todo_model.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';
import 'package:flutter_firebase_crud/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_firebase_crud/app/widgets/bottom_sheet_widget.dart';
import 'package:flutter_firebase_crud/app/widgets/dialog_widget.dart';
import 'package:flutter_firebase_crud/app/widgets/snackbar_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      child: Obx(() => Slidable(
            key: ValueKey(todoModel.documentId),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: netController.isOnline
                      ? _updateTodoSlide
                      : _noInternetSlide,
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: netController.isOnline
                      ? _deleteTodoSlide
                      : _noInternetSlide,
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: _buildListTile(),
          )),
    );
  }

  ListTile _buildListTile() {
    return ListTile(
        leading: Visibility(
          visible: netController.isOnline,
          child: Checkbox(
            shape: StadiumBorder(),
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
        trailing:
            NetController.instance.isOnline && todoModel.imageFileURL != ""
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: myBlueColor),
                    ),
                    child: Image.network(todoModel.imageFileURL!))
                : SizedBox.shrink());
  }

  void _updateTodoSlide(BuildContext? context) {
    if (netController.isOnline) {
      homeController.titleController.text = todoModel.title;
      homeController.contentController.text = todoModel.content;
      homeController.holdTitle.value = todoModel.title;
      homeController.holdContent.value = todoModel.content;
      homeController.changedDetect.value = "";

      CustomBottomSheetWidget.showBSheet(
          context: context,
          category: todoModel.category,
          docId: todoModel.documentId,
          controller: homeController);
    }
  }

  void _deleteTodoSlide(BuildContext? context) async {
    showDialog(
      context: context!,
      builder: (context) {
        return CustomDialogWidget(
          context: context,
          title: "Delete Todo",
          message: "Are you sure to delete todo ?\n(${todoModel.title})",
          onPress: () {
            FirestoreServices.deleteTodo(todoModel.documentId!);
            Get.back();
          },
        );
      },
    );
  }

  void _noInternetSlide(BuildContext? context) async {
    CustomSnackbarWidget.showSnackBar(
      title: "WARNING..!",
      context: Get.context!,
      message:
          'You are not connected to the internet.\n Make sure Wi-Fi is or Mobile Data on, Airplane Mode is Off and try again.',
      backgroundColor: myRedColor,
      icon: Icon(Icons.wifi_off_rounded, color: myWhiteColor),
    );
  }
}
