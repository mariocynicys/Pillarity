import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine/OnBoardScreens/OnBoardScreen_Page3.dart';
import 'package:page_transition/page_transition.dart';

class OnBoardScreenPage2 extends StatefulWidget {
  @override
  _OnBoardScreenPage2State createState() => _OnBoardScreenPage2State();
}

class _OnBoardScreenPage2State extends State<OnBoardScreenPage2> {
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
                  "Request Medicine",
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
                  "Now ",
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
                    child: TextButton(
                        onPressed: () => Navigator.push(
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
    );
  }
}
