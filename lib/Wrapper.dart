import 'package:flutter/material.dart';
import 'package:medicine/OnBoardScreens/OnBoardScreen_Page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'WelcomePage.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isitfirst = true;

  @override
  void initState() {
    super.initState();
    isitfirsttime();
  }

  void isitfirsttime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isitfirst = prefs.getBool("isitfirsttime") ?? true;
  }

  @override
  Widget build(BuildContext context) {
      if(isitfirst)
        return OnBoardScreen_Page1();
      else
        return WelcomePage();
  }
}
