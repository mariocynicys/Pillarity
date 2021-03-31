import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../WelcomePage.dart';

class OnBoardScreen_Page3 extends StatefulWidget {
  @override
  _OnBoardScreen_Page3State createState() => _OnBoardScreen_Page3State();
}

class _OnBoardScreen_Page3State extends State<OnBoardScreen_Page3> {
  void finish() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isitfirsttime", false);
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: WelcomePage(),
            duration: Duration(milliseconds: 500)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          height: 390,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Page3_Image.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                child: Text(
                  "Blood Donation",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    textStyle: TextStyle(
                      fontFamily: GoogleFonts.roboto.toString(),
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 8),
                child: Text(
                  "Ask for a donation from nearby users or help those in urgent need",
                  style: GoogleFonts.roboto(
                    color: Color.fromRGBO(90, 90, 90, 1),
                    textStyle: TextStyle(
                      fontFamily: GoogleFonts.roboto.toString(),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: FlatButton(
                        onPressed: () => finish(),
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/Next2.png"),
                            fit: BoxFit.contain,
                          )),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}