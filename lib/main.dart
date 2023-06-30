import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/allow.dart';
import 'package:flutter_app/drawer.dart';
import 'package:flutter_app/quiz_round.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAlodimlzU9fENywvVXQCd5WMp3D_XLbvY",
          authDomain: "quiz-app-797bc.firebaseapp.com",
          projectId: "quiz-app-797bc",
          storageBucket: "quiz-app-797bc.appspot.com",
          messagingSenderId: "961007306783",
          appId: "1:961007306783:web:d913d126eb1c26cacdad2a",
          measurementId: "G-35BE3DN95H"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const drawer(),
      debugShowCheckedModeBanner: false,
    );
  }
}
