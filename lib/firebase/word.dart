import "package:cloud_firestore/cloud_firestore.dart";
import "package:name_maker/model/word_model.dart";

class Word {
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

  static Future<dynamic> firestoreWordOut(String query) async {
    List<Map<String, dynamic>> wordData = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapDoc = await FirebaseFirestore
          .instance
          .collection("words")
          .where("leftright", isEqualTo: query)
          .get();
      snapDoc.docs.forEach((doc) {
        wordData.add(doc.data());
      });
      return wordData;
    } on FirebaseException catch (e) {
      print("error:$e");
      return false;
    }
  }
}
