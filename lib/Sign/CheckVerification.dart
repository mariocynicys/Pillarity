import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicine/Auth/auth.dart';
import 'package:medicine/Databases/FireStore.dart';
import 'package:medicine/Medicine/MedicineMainPage.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:medicine/WelcomePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../Databases/Local_DataBase.dart';

class VerificationPage extends StatefulWidget {
  final String userUid;
  final String email;

  VerificationPage({@required this.userUid, @required this.email});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    AuthServices().sendVerificationEmail();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      checker();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void checker() async {
    if (await AuthServices().checkEmailVerification()) {
      // if the user verified his email
      DocumentSnapshot list =
          await FireStoreServices(uid: widget.userUid).getUserData();


      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", widget.userUid);

      if (list.exists) {
        setState(() {
          DataBaseHelper().insertIntoInfo({
            DataBaseHelper().UID: widget.userUid,
            DataBaseHelper().Name:
                list.data()[FireStoreServices(uid: widget.userUid).Name],
            DataBaseHelper().Phone:
                list.data()[FireStoreServices(uid: widget.userUid).Phone],
            DataBaseHelper().Age:
                list.data()[FireStoreServices(uid: widget.userUid).Age],
            DataBaseHelper().Gender:
                list.data()[FireStoreServices(uid: widget.userUid).Gender],
            DataBaseHelper().Location:
                list.data()[FireStoreServices(uid: widget.userUid).Loaction],
            DataBaseHelper().Email:
                list.data()[FireStoreServices(uid: widget.userUid).Email],
            DataBaseHelper().BloodType:
                list.data()[FireStoreServices(uid: widget.userUid).BloodType]
          });
        });
      } else {
        Toast.show("Something went wrong", context);
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: WelcomePage(),
                duration: Duration(milliseconds: 1000)));
      }

      timer.cancel();
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: MedicineMainPage(),
              duration: Duration(milliseconds: 1000)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPumpingHeart(
            color: BloodActiveColor,
            size: 50,
          ),
          SizedBox(height: 20),
          Center(
            child: AutoSizeText("Please Verify Your Email",
                style: TextStyle(color: BloodActiveColor, fontSize: 20)),
          ),
          SizedBox(height: 10),
          Center(
            child: AutoSizeText("An Email has been send to",
                style: TextStyle(color: MedicineActiveColor, fontSize: 20)),
          ),
          SizedBox(height: 10),
          Center(
            child: AutoSizeText("${widget.email}",
                maxLines: 27,
                style: TextStyle(color: MedicineActiveColor, fontSize: 20)),
          ),
          SizedBox(height: 10),
          Center(
            child: AutoSizeText("Cannot wait to help other ${Emojis.redHeart}",
                style: TextStyle(color: BloodActiveColor, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
