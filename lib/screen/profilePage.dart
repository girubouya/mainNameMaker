import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:name_maker/firebase/auth.dart';
import 'package:name_maker/firebase/word.dart';
import 'package:name_maker/model/word_model.dart';

//Todo
//topはタイトル名
//ユーザー名出力
//登録名前一覧表示
//ページネーション
//名前の編集削除
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController wordEditController = TextEditingController();
    List<DocumentSnapshot> documents;
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
          child: Column(
        children: [
          Text(Auth.userData!.name),
          //名前一覧表示
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(Auth.currentUser!.uid)
                .collection("word")
                .orderBy("createdAt", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                documents = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(documents[index]["name"]),
                        leading: ElevatedButton.icon(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('編集'),
                                    content: TextField(
                                      controller: wordEditController,
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('no')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Word.firestoreWordUpdate(
                                                Auth.currentUser!.uid,
                                                documents[index]["id"],
                                                wordEditController.text);
                                            Navigator.pop(context, true);
                                          },
                                          child: Text('yes')),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                            label: Text('編集')),
                        trailing: ElevatedButton.icon(
                            onPressed: () async {
                              await Word.firestoreWordDelete(
                                  Auth.currentUser!.uid,
                                  documents[index]["id"]);
                            },
                            icon: Icon(Icons.delete),
                            label: Text('削除')),
                      );
                    },
                  ),
                );
              } else {
                return Text("NotData");
              }
            },
          ),
        ],
      )),
    );
  }
}
