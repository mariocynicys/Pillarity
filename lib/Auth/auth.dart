import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  saveUid(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", user.uid);
  }

  Future<User> getUser() async {
    return _auth.currentUser;
  }

  Future regWithEmailandPass(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user.uid;
    } catch (e) {
      print(e.toString());
      if (e.toString() ==
          "[firebase_auth/unknown] com.google.firebase.FirebaseException: An internal error has occurred. [ Unable to resolve host \"www.googleapis.com\":No address associated with hostname ]")
        _showMyDialog(
            context, "Error", "Please check your internet connection");
      else if (e.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.")
        _showMyDialog(
            context, "Error", "This email already belongs to an account");
      return null;
    }
  }

  Future<User> signWithEmailandpass(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      if (e.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.")
        _showMyDialog(context, "Error", "No User with this Email");
      else if (e.toString() ==
          "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.")
        _showMyDialog(context, "Error", "Invalid Password");
      else if (e.toString() ==
          "[firebase_auth/unknown] com.google.firebase.FirebaseException: An internal error has occurred. [ Unable to resolve host \"www.googleapis.com\":No address associated with hostname ]")
        _showMyDialog(
            context, "Error", "Please check your internet connection");
      else
        _showMyDialog(context, "Error", "Please try again later");
      return null;
    }
  }

  Future sendVerificationEmail() async {
    await _auth.currentUser.sendEmailVerification();
  }

  Future<bool> checkEmailVerification() async {
    User user = _auth.currentUser;
    await user.reload();
    return user.emailVerified;
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString("uid", "");
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _showMyDialog(BuildContext context, String title, String body) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body,
              style: TextStyle(color: MedicineActiveColor, fontSize: 20)),
          actions: <Widget>[
            TextButton(
              child: Text('OK',
                  style: TextStyle(color: MedicineActiveColor, fontSize: 17)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
