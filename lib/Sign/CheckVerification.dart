import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:emojis/emoji.dart'; // to use Emoji utilities
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicine/Auth/auth.dart';
import 'package:medicine/Database/FireStore.dart';
import 'package:medicine/Medicine/MedicineMainPage.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:medicine/WelcomePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

import '../DataBase.dart';

class VerificationPage extends StatefulWidget {
  String userUid;
  String email;

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
            DataBaseHelper().Loaction:
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
          SpinKitWave(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? MedicineActiveColor : BloodActiveColor,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Center(
            child: AutoSizeText("Please Verify Your Email",
                style: TextStyle(color: BloodActiveColor, fontSize: 20)),
          ),
          SizedBox(height: 10),
          Center(
            child: AutoSizeText("An Email has been send to ${widget.email}",
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
