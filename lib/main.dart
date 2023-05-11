import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_password_generate_app/Controller/Auth_Controller.dart';
import 'View/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(
          baseAuthHelper: AuthController(),
        ),
      );
}
