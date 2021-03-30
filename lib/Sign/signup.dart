import 'package:country_list_pick/country_list_pick.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine/Bezier/bezierContainer.dart';
import 'package:medicine/ChoosePage.dart';
import 'package:medicine/Medicine/MedicineMainPage.dart';
import 'LoginPage.dart';
import '../Shared/SharedConstants.dart';
import '../Shared/SharedWidgets.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = '';
  String pass = '';
  String age = '';
  String name = '';
  String _gender = "Male";
  final _key = GlobalKey<FormState>();

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value.isEmpty)
                  return "Please enter Text";
                else
                  return null;
              },
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _title() {
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
              style: TextStyle(color: Color.fromRGBO(203, 0, 254, 1), fontSize: 30),
            ),
            TextSpan(
              text: appTitle.substring(4,appTitle.length),
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _nameField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (String value) => name=value,

              validator: (value) {
                if (value.isEmpty)
                  return "Please Enter your Name";

                else
                  return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _ageGender() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Age",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  onChanged: (String value) => age=value,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter your Age";
                    else {
                      // To check if user enters numbers only
                      try {
                        var myInt = int.parse(value);
                        assert(myInt is int);
                      } catch (e) {
                        return "Please Enter Numbers only";
                      }
                      return null;
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        )),
        Expanded(child: _GenderBox()),
      ],
    );
  }

  Widget _emailPassword() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                  onChanged: (String value) => email=value,
                  validator: (value) {
                    if (!EmailValidator.validate(value))
                      return "Please enter a valid email";
                    else

                      return null;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                  onChanged: (String value) => pass=value,
                  validator: (value) {
                    if (value.length < 8)
                      return "Please Choose 8 char Password";
                    else
                      return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
      ],
    );
  }

  Widget RegisterButton() {
    return InkWell(
      onTap: () {
        if (_key.currentState.validate()) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MedicineMainPage()));
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
          "Register Now",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _GenderBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Color(0xfff3f3f4),
            child: DropdownButton<String>(
                isExpanded: true,
                elevation: -1,
                value: _gender,
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _gender = value)),
          ),
        ],
      ),
    );
  }

  Widget _CountryBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Country",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Color(0xfff3f3f4),
            child: CountryListPick(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(183, 0, 143, 1),
                  title: Text('Choose Your Country'),
                ),
                // if you need costume picker use this
                pickerBuilder: (context, CountryCode countryCode) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        countryCode.flagUri,
                        package: 'country_list_pick',
                        height: 40,
                      ),
                      SizedBox(width: 15),
                      Text(countryCode.name),
                    ],
                  );
                },
                // To disable option set to false
                theme: CountryTheme(
                  alphabetSelectedBackgroundColor:
                      Color.fromRGBO(203, 0, 254, 1),
                  alphabetSelectedTextColor: Colors.black,
                  lastPickText: "Country Selected",
                  isShowFlag: true,
                  isShowTitle: true,
                  isShowCode: false,
                  isDownIcon: false,
                  showEnglishName: true,
                ),
                onChanged: (CountryCode country) {},
                // Set default value
                initialSelection: '+20',
                // Whether to allow the widget to set a custom UI overlay
                useUiOverlay: true,
                // Whether the country list should be wrapped in a SafeArea
                useSafeArea: false),
          ),
        ],
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
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

  Widget _mainRegisterationForm() {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          _nameField(),
          _ageGender(),
          _CountryBox(),
          _emailPassword(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              // Clip
              Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(divisor: 3.5),
              ),
              Positioned(top: 40, left: 0, child: backButton(context)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      _mainRegisterationForm(),
                      SizedBox(height: 20),
                      RegisterButton(),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
