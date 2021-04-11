import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'OnBoardScreen_Page3.dart';

class OnBoardScreenPage1 extends StatefulWidget {
  @override
  _OnBoardScreenPage1State createState() => _OnBoardScreenPage1State();
}

class _OnBoardScreenPage1State extends State<OnBoardScreenPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              image: AssetImage("assets/Request_Medicine_Page.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Center(
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
                        image: AssetImage("assets/Page1_Image.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                  child: Text(
                    "Medicine Sharing",
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
                    "You can either give the remaining medicine to people in need or ask for it",
                    style: GoogleFonts.roboto(
                      color: Color.fromRGBO(90, 90, 90, 1),
                      textStyle: TextStyle(
                        fontFamily: GoogleFonts.roboto.toString(),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: OnBoardScreenPage3(),
                                  duration: Duration(milliseconds: 1000))),
                          child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Next1.png"),
                              fit: BoxFit.contain,
                            )),
                          )),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
