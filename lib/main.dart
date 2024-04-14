import 'package:flutter/material.dart';
import 'package:name_maker/screen/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:name_maker/screen/loginPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 246, 118, 95)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
