import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SharedConstants.dart';

Widget myTitle() {
  // Medicine
  return RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
        text: appTitle[0],
        style: GoogleFonts.portLligatSans(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: appTitle.substring(1,4),
            style: TextStyle(color: bloodColor, fontSize: 30),
          ),
          TextSpan(
            text: appTitle.substring(4,appTitle.length),
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ]),
  );
}

Widget backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}