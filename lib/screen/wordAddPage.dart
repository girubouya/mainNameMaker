import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:name_maker/firebase/wordAdd.dart';
import 'package:name_maker/model/word_model.dart';

class WordAddPage extends StatefulWidget {
  const WordAddPage({super.key});

  @override
  State<WordAddPage> createState() => _WordAddPageState();
}

class _WordAddPageState extends State<WordAddPage> {
  LeftRight selectValue = LeftRight.left;
  @override
  Widget build(BuildContext context) {
    TextEditingController wordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('名前追加'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: wordController,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('左'),
                      leading: Radio(
                          value: LeftRight.left,
                          groupValue: selectValue,
                          onChanged: (value) {
                            setState(() {
                              selectValue = value!;
                            });
                          }),
                    ),
                    ListTile(
                      title: Text('右'),
                      leading: Radio(
                          value: LeftRight.right,
                          groupValue: selectValue,
                          onChanged: (value) {
                            setState(() {
                              selectValue = value!;
                            });
                          }),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    WordModel word = WordModel(
                        name: wordController.text,
                        leftright: selectValue,
                        createdAt: Timestamp.now(),
                        updatedAt: Timestamp.now());
                    final result = await WordAdd.firestoreWordAdd(word);
                    if (result == true) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('追加'))
            ],
          ),
        ),
      ),
    );
  }
}
