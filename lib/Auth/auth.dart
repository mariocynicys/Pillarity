import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel getUserUid(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  saveUid(User user) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", user.uid);
  }

  Future regWithEmailandpass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      saveUid(user);
      return getUserUid(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signWithEmailandpass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      saveUid(user);
      return getUserUid(user);
    } catch (e) {
      
      print(e.toString());
      return null;
    }
  }

  Stream<UserModel> isSignedin() {
    return _auth.authStateChanges().map(getUserUid);
  }

  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
