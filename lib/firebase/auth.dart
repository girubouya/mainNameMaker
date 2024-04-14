import "package:firebase_auth/firebase_auth.dart";
import "package:name_maker/model/user_model.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Auth {
  static User? currentUser;
  static UserModel? userData;
  static UserCredential? anoUser;

//新規アカウント作成
  static Future<dynamic> signUp(
      String email, String password, String name) async {
    try {
      //新規作成処理
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //データベースにユーザー情報保存処理
      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set({
        "name": name,
        "email": email,
        "id": credential.user!.uid,
        "createdAt": Timestamp.now(),
        "updatedAt": Timestamp.now(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("パスワードが弱いです");
      } else if (e.code == 'email-already-in-use') {
        print('すでにメールアドレスは使われています');
      } else {
        print('アカウント作成失敗');
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> signIn(String email, String password) async {
    try {
      //ログイン処理
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //ログインしているユーザー取得
      currentUser = user.user;
      //ログインユーザーの情報をデータベースから取得
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(currentUser!.uid)
          .get();

      Map<String, dynamic> loginUserData = doc.data() as Map<String, dynamic>;
      userData = UserModel(
          name: loginUserData['name'],
          email: loginUserData['email'],
          id: loginUserData['id'],
          createdAt: loginUserData['createdAt'],
          updatedAt: loginUserData['updatedAt']);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("パスワードが弱いです");
      } else if (e.code == 'email-already-in-use') {
        print('すでにメールアドレスは使われています');
      } else {
        print('アカウント作成失敗');
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Auth.currentUser = FirebaseAuth.instance.currentUser;
      return true;
    } on FirebaseAuthException catch (e) {
      print("エラー$e");
      return false;
    }
  }

  static Future<dynamic> anonymouth() async {
    try {
      anoUser = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.$anoUser");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }
}
