import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/remote/controllers/todo_controller.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';
import 'package:flutter_firebase_crud/app/widgets/no_entry_widget.dart';
import 'package:flutter_firebase_crud/app/widgets/show_entry_listview_widget.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Obx(() => Text(
                NetController.instance.isOnline
                    ? "Todo List - Home"
                    : "Todo List - Home (Offline) ",
                style: TextStyle(fontSize: 20),
              )),
        ),
        body: Obx(
          () => TodoController.instance.todos.isEmpty
              ? NoEntryWidget(netContoller: NetController.instance)
              : ShowEntryListView(
                  todoController: TodoController.instance,
                  controller: HomeController.instance,
                  netContoller: NetController.instance,
                  items: TodoController.instance.todos),
        ));
  }
}
