import 'package:flutter_firebase_crud/app/data/remote/services/services.dart';
import 'package:flutter_firebase_crud/app/data/remote/models/todo_model.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/modules/history/controllers/history_controller.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  static TodoController instance = Get.put(TodoController());
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>([]);
  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    collectionReference = firebaseFirestore.collection("todos");
    todoList.bindStream(FirestoreServices.getTodos());
    ever(todoList, (_)=>HistoryController.instance.onInit());
    super.onInit();
  }
}
