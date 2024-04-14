import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:name_maker/screen/wordAddPage.dart';

enum LeftRight {
  left(leftright: "左"),
  right(leftright: "右");

  final String leftright;
  const LeftRight({required this.leftright});
}

class WordModel {
  String name;
  LeftRight leftright;
  Timestamp createdAt;
  Timestamp updatedAt;
  WordModel(
      {required this.name,
      required this.leftright,
      required this.createdAt,
      required this.updatedAt});
}
