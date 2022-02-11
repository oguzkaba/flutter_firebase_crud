import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/todo_controller.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/bottom_sheet_widget.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/card_widget.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:flutter_firebase_crud/global/internet_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final TodoController todoController = Get.put(TodoController());
  final NetController netContoller = Get.put(NetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: Obx(
        () =>
            todoController.todos.isEmpty ? noEntryWidget() : _showEntryWidget(),
      ),
      floatingActionButton: _fabWidget(context),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      centerTitle: true,
      title: Obx(() => Text(
            netContoller.isOnline ? "Todo List" : "Todo List (Offline) ",
            style: TextStyle(fontSize: 20),
          )),
      leading: Icon(Icons.checklist_rounded, color: myBlueColor),
    );
  }

  Obx _fabWidget(BuildContext context) {
    return Obx(() => Visibility(
        visible: netContoller.isOnline,
        child: FloatingActionButton(
          backgroundColor: myBlueColor,
          child: Icon(Icons.add),
          onPressed: () {
            controller.clearEditingControllers();
            controller.changedDetect.value = "";
            CustomBottomSheetWidget.showBSheet(
                context: context,
                text: 'ADD',
                controller: controller,
                docId: "");
          },
          tooltip: "ADD Todo",
        )));
  }

  ListView _showEntryWidget() {
    return ListView.builder(
      itemCount: todoController.todos.length,
      itemBuilder: (BuildContext context, int index) {
        //print(todoController.todos[index].content);
        final _todoModel = todoController.todos[index];
        return TodoCardWidget(
            todoModel: _todoModel,
            homeController: controller,
            netController: netContoller);
      },
    );
  }

  Center noEntryWidget() {
    return Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
      Icon(Icons.event_busy,
          color: myRedColor.withOpacity(0.05), size: Get.width),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
            netContoller.isOnline ? noEntryOnlineText : noEntryOfflineText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18)),
      ),
    ]));
  }
}
