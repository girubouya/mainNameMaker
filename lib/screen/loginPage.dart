import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:name_maker/firebaseAuth/auth.dart';
import 'package:name_maker/screen/homePage.dart';
import 'package:name_maker/screen/signUpPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    print(Auth.currentUser);

    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "email", hintText: "test@gmail.com"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: "password", hintText: "testtest"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  final result = await Auth.signIn(
                      emailController.text, passwordController.text);
                  if (result == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homePage()));
                  }
                },
                child: const Text('login')),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  await Auth.anonymouth();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => homePage()));
                },
                child: const Text('GuestLogin')),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: const Text('SignUp'))
          ],
        ),
      ),
    );
  }
}
