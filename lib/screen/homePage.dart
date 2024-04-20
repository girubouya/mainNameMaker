import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:name_maker/firebase/auth.dart';
import 'package:name_maker/firebase/word.dart';
import 'package:name_maker/screen/loginPage.dart';
import 'package:name_maker/screen/profilePage.dart';
import 'package:name_maker/screen/wordAddPage.dart';
import 'dart:math' as math;

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String leftName = "";
  String rightName = "";
  @override
  Widget build(BuildContext context) {
    final bool loginCheck;
    //ログインしたか匿名ログインかチェック
    if (Auth.currentUser != null) {
      loginCheck = true;
    } else {
      loginCheck = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Text(
                    loginCheck ? "home(${Auth.userData!.name})" : "home(匿名)")),
            ElevatedButton(
                onPressed: () async {
                  if (loginCheck) {
                    final result = await Auth.logout();
                    if (result == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }
                },
                child: Text(loginCheck ? "ログアウト" : "ログイン")),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //左の名前の出力場所とボタン
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Text(
                        leftName,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var result = await Word.firestoreWordOut("左");
                          if (result is List<Map<String, dynamic>>) {
                            final wordMax = result.length;
                            var random = math.Random();
                            setState(() {
                              leftName =
                                  result[random.nextInt(wordMax)]["name"];
                            });
                          }
                        },
                        child: const Text("出力")),
                  ],
                ),
                //右の名前の出力場所とボタン
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Text(
                        rightName,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var result = await Word.firestoreWordOut("右");
                          if (result is List<Map<String, dynamic>>) {
                            final wordMax = result.length;
                            var random = math.Random();
                            setState(() {
                              rightName =
                                  result[random.nextInt(wordMax)]["name"];
                            });
                          }
                        },
                        child: const Text("出力")),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          //リセットボタン
          ElevatedButton(onPressed: () {}, child: const Text('リセット')),
          //名前追加ボタン
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WordAddPage()));
              },
              child: const Text('名前追加')),
        ],
      ),
    );
  }
}
