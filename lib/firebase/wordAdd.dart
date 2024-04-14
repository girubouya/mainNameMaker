import "package:cloud_firestore/cloud_firestore.dart";
import "package:name_maker/model/word_model.dart";

class WordAdd {
  static Future<bool> firestoreWordAdd(WordModel word) async {
    try {
      await FirebaseFirestore.instance.collection("words").doc().set({
        "name": word.name,
        "leftright": word.leftright.leftright,
        "createdAt": Timestamp.now(),
        "updatedAt": Timestamp.now(),
      });
      return true;
    } on FirebaseException catch (e) {
      print("error:$e");
      return false;
    }
  }
}
