import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/services.dart';
import 'package:flutter_firebase_crud/app/data/todo_model.dart';
import 'package:flutter_firebase_crud/app/modules/widgets/dialog_widget.dart';
import 'package:get/get.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;
  const TodoCardWidget({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoModel.complated
          ? Colors.redAccent.withOpacity(0.2)
          : Colors.white,
      shadowColor: todoModel.complated ? Colors.transparent : null,
      child: ListTile(
        leading: Checkbox(
          value: todoModel.complated,
          onChanged: (status) {
            FirestoreServices.updateTodoComplated(
                status!, todoModel.documentId);
          },
        ),
        title: Text(todoModel.title,
            style: TextStyle(overflow: TextOverflow.ellipsis)),
        subtitle: Text(todoModel.content,
            style: TextStyle(overflow: TextOverflow.ellipsis)),
        isThreeLine: true,
        trailing: IconButton(
            onPressed: () => CustomDialogWidget.showDialogWidget(
                  context: Get.context,
                  title: "Delete Todo",
                  message: "Are you sure to delete todo ?",
                  docId: todoModel.documentId!,
                ),
            icon: const Icon(Icons.delete, color: Colors.red)),
      ),
    );
  }
}
