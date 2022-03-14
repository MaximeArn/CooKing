import 'package:cooking/environment/env.dart';
import 'package:cooking/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  void comparePasswords({
    required String password,
    required String confirmPassword,
  }) {
    final bool isIdentical = password == confirmPassword;
    if (!isIdentical) {
      throw FirebaseAuthException(
        code: "different_passwords",
        message: "Passwords must be identical",
      );
    }
  }

  void register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    Utils.showLoader();
    try {
      comparePasswords(password: password, confirmPassword: confirmPassword);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //TODO: make an http request to create a user in the DB
      http.Response res = await http.post(Uri.parse("$serverUrl/users")); 
      Utils.navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(text: e.message);
      rethrow;
    }
  }
}
