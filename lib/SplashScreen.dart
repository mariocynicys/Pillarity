import 'package:flutter/material.dart';
import 'package:medicine/Medicine/Medicine_Main_Posts.dart';
import 'package:medicine/Models/UserModel.dart';
import 'package:medicine/OnBoardScreens/OnBoardScreen_Page1.dart';
import 'package:medicine/WelcomePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _firstTime = false;
  UserModel user;

  @override
  void initState() {
    super.initState();

    read();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade, child: WelcomePage()));
      // if (_firstTime)
      //   Navigator.push(
      //       context,
      //       PageTransition(
      //           type: PageTransitionType.fade,
      //           child: OnBoardScreen_Page1(),
      //           duration: Duration(milliseconds: 1000)));
      // else {
      //   if (user.uid == "")
      //     Navigator.pushReplacement(
      //         context,
      //         PageTransition(
      //             type: PageTransitionType.fade, child: WelcomePage()));
      //   else {
      //     Navigator.pushReplacement(
      //         context,
      //         PageTransition(
      //             type: PageTransitionType.fade, child: MedicineMainPosts()));
      //   }
      // }
    });
  }

  void read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstTime = prefs.getBool("isitfirsttime") ?? true;
    user.uid = prefs.getString("uid") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Splash Page.png'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
