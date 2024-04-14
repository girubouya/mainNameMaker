import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:name_maker/firebaseAuth/auth.dart';
import 'package:name_maker/screen/loginPage.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

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
            Text(loginCheck ? "home(${Auth.userData!.name})" : "home(匿名)"),
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
                      child: const Text(
                        "word",
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("出力")),
                  ],
                ),
                //右の名前の出力場所とボタン
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Text(
                        "word",
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("出力")),
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
          ElevatedButton(onPressed: () {}, child: const Text('名前追加')),
        ],
      ),
    );
  }
}
