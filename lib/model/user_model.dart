import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String id;
  Timestamp createdAt;
  Timestamp updatedAt;
  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
}
