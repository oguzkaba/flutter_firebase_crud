import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_crud/app/data/todo_controller.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/global/constants.dart';
import 'package:get/get.dart';

class FirestoreServices {
//Create Operation
  static addTodo(TodoModel todomodel) async {
    await firebaseFirestore.collection('todos').add({
      'title': todomodel.title,
      'content': todomodel.content,
      'createDate': Timestamp.now(),
      'complated': false,
    });
  }

//Read Operation
  static Stream<List<TodoModel>> getTodos() {
    return firebaseFirestore
        .collection('todos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> todos = [];
      for (var todo in query.docs) {
        final todoModel =
            TodoModel.fromDocumentSnapshot(documentSnapshot: todo);
        todos.add(todoModel);
      }
      return todos;
    });
  }

//Update Operation
  static updateTodo(TodoModel todomodel) {
    firebaseFirestore.collection('todos').doc(todomodel.documentId).update(
      {
        'title': todomodel.title,
        'content': todomodel.content,
        'createDate': Timestamp.now(),
        'complated': false,
      },
    );
  }

  static updateTodoComplated(bool isComplate, documentId) {
    firebaseFirestore.collection('todos').doc(documentId).update(
      {
        'complated': isComplate,
      },
    );
  }

//Delete Operation
  static deleteTodo(String documentId) {
    firebaseFirestore.collection('todos').doc(documentId).delete();
  }
}
