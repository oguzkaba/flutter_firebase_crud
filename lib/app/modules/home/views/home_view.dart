import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_controller.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetX<TodoController>(
          init: Get.put<TodoController>(TodoController()),
          builder: (TodoController todoController) {
            return Expanded(
              child: ListView.builder(
                itemCount: todoController.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  print(todoController.todos[index].content);
                  final _todoModel = todoController.todos[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _todoModel.content,
                              style: TextStyle(
                                fontSize: Get.textTheme.headline6!.fontSize,
                                decoration: _todoModel.complated
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: _todoModel.complated,
                            onChanged: (status) {
                              FirestoreDb.updateStatus(
                                status!,
                                _todoModel.documentId,
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              FirestoreDb.deleteTodo(_todoModel.documentId!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
