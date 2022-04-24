import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? documentId;
  late String title;
  late String content;
  late Timestamp createDate;
  late String? imageFileURL;
  late String category;
  late bool complated;

  TodoModel(
      {required this.title,
      required this.content,
      required this.category,
      this.documentId,
      this.imageFileURL});

  TodoModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    title = documentSnapshot['title'];
    content = documentSnapshot["content"];
    createDate = documentSnapshot["createDate"];
    imageFileURL = documentSnapshot["imageFileURL"] ?? "";
    category = documentSnapshot["category"];
    complated = documentSnapshot["complated"];
  }
}
