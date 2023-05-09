import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_password_generate_app/View/Home_Screen.dart';

import '../Widgets/My_Alert.dart';

abstract class BaseAuthController {
  Future<void> loginAuth(
      {required String email, required String password, required context});
  Future<void> registerAuth(
      {required String email, required String password, required context});
}

class AuthController extends BaseAuthController {
  @override
  Future loginAuth(
      {required String email,
      required String password,
      required context}) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (currentUser == null) {
        const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      }

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (_) {
              return myAlert(
                  content: "No user found for that email.", context: context);
            });
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (_) {
              return myAlert(
                  content: "Wrong password provided for that user.",
                  context: context);
            });
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return myAlert(content: "Not Complete Email", context: context);
            });
      }
    }
  }

  @override
  Future registerAuth(
      {required String email,
      required String password,
      required context}) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (currentUser == null) {
        const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      }

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (_) {
              return myAlert(
                  content: "The Password is too Weak", context: context);
            });
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (_) {
              return myAlert(
                  context: context,
                  content: "The account already exists for that email.");
            });
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return myAlert(
                  context: context,
                  content:
                      "you Should Write Your Full Email .Example: user11@Example.com");
            });
      }
    } catch (e) {
      //
    }
  }
}
