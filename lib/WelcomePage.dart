import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Sign/RegisterPage.dart';

import 'Sign/LoginPage.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    // fireBaseMessagingConfigure();
  }

  // fireBaseMessagingConfigure() async {
  //   _firebaseMessaging.configure(
  //     // When the user is currently using the application
  //     onMessage: (message) async {
  //       print("onMessage: $message");
  //     },
  //     //When th app is in the background
  //     onResume: (message) async {
  //       // To make this code executed, we have to add "click_action" as key and
  //       // "FLUTTER_NOTIFICATION_CLICK" as its value ( in the notification data)
  //       print("onResume: $message");
  //     },
  //     //When the app is closed
  //     onLaunch: (message) async {
  //       // To make this code executed, we have to add "click_action" as key and
  //       // "FLUTTER_NOTIFICATION_CLICK" as its value (in the notification data)
  //       print("onLaunch: $message");
  //     },
  //   );
  // }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(193, 0, 200, 1),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color.fromRGBO(193, 0, 200, 1)),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    // Title = Medicine
    return Container(
      height: 65,
        width: 250,
        decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/Pillarity.png'),fit: BoxFit.contain),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color.fromRGBO(183, 0, 143, 1), Color.fromRGBO(203, 0, 254, 1)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               _title(),
              SizedBox(height: 30),
              _loginButton(),
              SizedBox(height: 20),
              _registerButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
