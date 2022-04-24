// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/remote/controllers/todo_controller.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';
import 'package:flutter_firebase_crud/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_firebase_crud/app/widgets/no_entry_widget.dart';
import 'package:flutter_firebase_crud/app/widgets/show_entry_listview_widget.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

// ignore: must_be_immutable
class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => Text(
              NetController.instance.isOnline
                  ? "Todo List - History"
                  : "Todo List - History (Offline) ",
              style: TextStyle(fontSize: 20),
            )),
      ),
      body: Obx(
        () => HistoryController.instance.historyTodos.isEmpty
            ? NoEntryWidget(netContoller: NetController.instance)
            : ShowEntryListView(
                todoController: TodoController.instance,
                netContoller: NetController.instance,
                controller: HomeController.instance,
                items: HistoryController.instance.historyTodos),
      ),
    );
  }
}
