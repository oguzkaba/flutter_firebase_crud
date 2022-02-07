import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? documentId;
  late String title;
  late String content;
  late Timestamp createDate;
  late bool complated;

  TodoModel({
    required this.content,
    required this.complated,
    required this.createDate,
  });

  TodoModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    title = documentSnapshot['title'];
    content = documentSnapshot["content"];
    createDate = documentSnapshot["createDate"];
    complated = documentSnapshot["complated"];
  }
}