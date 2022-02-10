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
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => Text(netContoller.isOnline ? "Todo List" : "Offline")),
        actions: [
          Visibility(
            visible: netContoller.isOnline,
            child: IconButton(
              icon: Icon(Icons.add, color: myBlueColor),
              onPressed: () => CustomBottomSheetWidget.showBSheet(
                  context: context, text: 'ADD', controller: controller),
            ),
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (BuildContext context, int index) {
            //print(todoController.todos[index].content);
            final _todoModel = todoController.todos[index];
            return TodoCardWidget(
                todoModel: _todoModel,
                homeController: controller,
                netController: netContoller);
          },
        ),
      ),
    );
  }

//TODO: Update Save todos
  // _buildAddEditTodoView({String? text, String? docId}) {
  //   Get.bottomSheet(
  //     Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(16),
  //           topLeft: Radius.circular(16),
  //         ),
  //         color: Colors.white,
  //       ),
  //       child: Padding(
  //         padding:
  //             const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
  //         child: Form(
  //           key: controller.formKey,
  //           autovalidateMode: AutovalidateMode.onUserInteraction,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '$text Todo',
  //                   style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.bold,
  //                       color: myBlueColor),
  //                 ),
  //                 SizedBox(
  //                   height: 18,
  //                 ),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     hintText: 'Title',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                   ),
  //                   controller: controller.titleController,
  //                   validator: (value) {
  //                     return controller.validateTitle(value!);
  //                   },
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 TextFormField(
  //                   maxLines: 5,
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Content',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                   ),
  //                   controller: controller.contentController,
  //                   validator: (value) {
  //                     return controller.validateContent(value!);
  //                   },
  //                 ),
  //                 SizedBox(
  //                   height: 8,
  //                 ),
  //                 ConstrainedBox(
  //                   constraints: BoxConstraints.tightFor(
  //                       width: Get.context!.width, height: 45),
  //                   child: ElevatedButton(
  //                     child: Text(
  //                       text!,
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                     style: ElevatedButton.styleFrom(
  //                       primary: myBlueColor,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       controller.saveUpdateTodo(
  //                           controller.titleController.text,
  //                           controller.contentController.text,
  //                           todo,
  //                           text);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
