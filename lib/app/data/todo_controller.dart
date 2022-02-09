import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>([]);
  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    collectionReference = firebaseFirestore.collection("todos");
    todoList.bindStream(FirestoreServices.getTodos());
    super.onInit();
  }
}
