import 'package:flutter_firebase_crud/app/data/remote/controllers/todo_controller.dart';
import 'package:flutter_firebase_crud/app/data/remote/models/todo_model.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  static HistoryController instance = Get.put(HistoryController());
  Rx<List<TodoModel>> historyTodoList = Rx<List<TodoModel>>([]);
  List<TodoModel> get historyTodos => historyTodoList.value;

  @override
  void onInit() {
    todoCalculate();
    super.onInit();
  }

  void todoCalculate() {
    historyTodoList.value = [];

    for (var item in TodoController.instance.todos) {
      if (item.complated) {
        historyTodoList.value.add(item);
      }
    }
  }
}
