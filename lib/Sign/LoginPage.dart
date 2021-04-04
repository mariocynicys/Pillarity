import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'CheckVerification.dart';
import 'package:medicine/Auth/auth.dart';
import 'package:medicine/Bezier/bezierContainer.dart';
import 'package:medicine/Database/FireStore.dart';
import 'package:medicine/Medicine/MedicineMainPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import '../DataBase.dart';
import 'RegisterPage.dart';
import '../Shared/SharedConstants.dart';
import '../Shared/SharedWidgets.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String pass = "";
  final _Key = new GlobalKey<FormState>();

  Widget _email() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              autofillHints: [AutofillHints.email],
              onChanged: (String value) => email = value,
              validator: (String value) {
                if (!EmailValidator.validate(value))
                  return "Email is not Correct";
                else
                  return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: MedicineActiveColor,
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _pass() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              autofillHints: [AutofillHints.password],
              onChanged: (String value) => pass = value,
              validator: (String value) {
                if (value.length < 8)
                  return "Password Should be more than 8 Characters";
                else
                  return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.vpn_key_outlined,
                    color: MedicineActiveColor,
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    // Medicine
    return Container(
        height: 60,
        width: 220,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/InvertedLogo.png'), fit: BoxFit.cover),
        ));
  }

  Widget _createAccountLabel() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color.fromRGBO(183, 0, 143, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _Key,
      child: Column(
        children: <Widget>[_email(), _pass()],
      ),
    );
  }

  Widget login_Button() {
    return InkWell(
      onTap: () async {
        if (_Key.currentState.validate()) {
          var result =
              await AuthServices().signWithEmailandpass(email, pass, context);

          if (result != null) {
            if (await AuthServices().checkEmailVerification()) {
              // if the user already Verified his email
              DocumentSnapshot list =
                  await FireStoreServices(uid: result.uid).getUserData();
              var r2;

              if (list.exists) {
                setState(() {
                  r2 = DataBaseHelper().insertIntoInfo({
                    DataBaseHelper().UID: result.uid,
                    DataBaseHelper().Name:
                        list.data()[FireStoreServices(uid: result.uid).Name],
                    DataBaseHelper().Phone:
                        list.data()[FireStoreServices(uid: result.uid).Phone],
                    DataBaseHelper().Age:
                        list.data()[FireStoreServices(uid: result.uid).Age],
                    DataBaseHelper().Gender:
                        list.data()[FireStoreServices(uid: result.uid).Gender],
                    DataBaseHelper().Loaction: list
                        .data()[FireStoreServices(uid: result.uid).Loaction],
                    DataBaseHelper().Email:
                        list.data()[FireStoreServices(uid: result.uid).Email],
                    DataBaseHelper().BloodType: list
                        .data()[FireStoreServices(uid: result.uid).BloodType]
                  });
                });
              }

              if (r2 != 0)
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: MedicineMainPage(),
                        duration: Duration(milliseconds: 1000)));
            } else
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: VerificationPage(userUid: result.uid, email: email),
                      duration: Duration(milliseconds: 1000)));
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
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
                colors: [
                  Color.fromRGBO(183, 0, 143, 1),
                  Color.fromRGBO(203, 0, 254, 1)
                ])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(divisor: 3.5)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .21),
                  _title(),
                  // SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  login_Button(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: 20),
                  _divider(),
                  _facebookButton(),
                  _createAccountLabel(),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: backButton(context)),
        ],
      ),
    ));
  }
}
