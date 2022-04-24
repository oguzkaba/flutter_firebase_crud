import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/remote/controllers/todo_controller.dart';
import 'package:flutter_firebase_crud/app/data/remote/models/todo_model.dart';
import 'package:flutter_firebase_crud/app/global/controllers/internet_controller.dart';
import 'package:flutter_firebase_crud/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_firebase_crud/app/widgets/card_widget.dart';

class ShowEntryListView extends StatelessWidget {
  const ShowEntryListView({
    Key? key,
    required this.todoController,
    required this.controller,
    required this.netContoller,
    required this.items
  }) : super(key: key);

  final TodoController todoController;
  final HomeController? controller;
  final NetController netContoller;
  final List<TodoModel> items;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        //print(todoController.todos[index].content);
        final _todoModel = items[index];
        return TodoCardWidget(
            todoModel: _todoModel,
            homeController: controller!,
            netController: netContoller);
      },
    );
  }
}