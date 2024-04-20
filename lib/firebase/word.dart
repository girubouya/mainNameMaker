import "package:cloud_firestore/cloud_firestore.dart";
import "package:name_maker/firebase/auth.dart";
import "package:name_maker/model/word_model.dart";

class Word {
  static Future<bool> firestoreWordAdd(WordModel word) async {
    try {
      DocumentReference<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection("words").add({
        "name": word.name,
        "leftright": word.leftright.leftright,
        "createdAt": Timestamp.now(),
        "updatedAt": Timestamp.now(),
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(Auth.currentUser!.uid)
          .collection("word")
          .doc(data.id)
          .set({
        "name": word.name,
        "leftright": word.leftright.leftright,
        "createdAt": Timestamp.now(),
        "updatedAt": Timestamp.now(),
        "id": data.id
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

  static Future<dynamic> firestoreWordDelete(String uid, String id) async {
    await FirebaseFirestore.instance.collection("words").doc(id).delete();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("word")
        .doc(id)
        .delete();
    return true;
  }

  static Future<dynamic> firestoreWordUpdate(
      String uid, String id, String word) async {
    await FirebaseFirestore.instance.collection("words").doc(id).update({
      "name": word,
      "updatedAt": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("word")
        .doc(id)
        .update({
      "name": word,
      "updatedAt": Timestamp.now(),
    });
  }
}
