import 'package:country_list_pick/country_list_pick.dart';
import 'package:email_validator/email_validator.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicine/Databases/FireStore.dart';
import 'package:page_transition/page_transition.dart';
import 'CheckVerification.dart';
import 'package:medicine/Auth/auth.dart';
import 'package:medicine/Bezier/bezierContainer.dart';
import 'LoginPage.dart';
import '../Shared/SharedConstants.dart';
import '../Shared/SharedWidgets.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String pass = '';
  String age = '';
  String name = '';
  String country = 'Egypt';
  String gender = "Male";
  String bloodType = "A+";
  String phone = "";
  bool loading = false;
  final _key = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

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
    return Container(
        height: 60,
        width: 220,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/InvertedLogo.png'), fit: BoxFit.cover),
        ));
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
              onChanged: (String value) => setState(() => name = value),
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
                  onChanged: (String value) => setState(() => age = value),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter your Age";
                    else {
                      // To check if user enters numbers only
                      try {
                        var myInt = int.parse(value);
                        assert(myInt is int);
                        if (myInt > 112 || myInt < 12) return "Please Enter a Valid age";
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

  Widget _bloodBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Blood Type",
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
                value: bloodType,
                items: <String>[
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() => bloodType = value)),
          ),
        ],
      ),
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
                  autofillHints: [AutofillHints.email],
                  onChanged: (String value) => setState(() => email = value),
                  validator: (value) {
                    if (!EmailValidator.validate(value))
                      return "Please enter a valid email";
                    else
                      return null;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: MedicineActiveColor),
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
                  autofillHints: [AutofillHints.password],
                  onChanged: (String value) => setState(() => pass = value),
                  validator: (value) {
                    if (value.length < 8)
                      return "Please Choose 8 char Password";
                    else
                      return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key_outlined,
                          color: MedicineActiveColor),
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
      ],
    );
  }

  Widget _phone() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Phone Number",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              autofillHints: [AutofillHints.telephoneNumber],
              onChanged: (String value) => setState(() => phone = value),
              validator: (value) {
                if (value.isEmpty)
                  return "Please Enter your Phone";
                else
                  return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.local_phone_outlined,
                      color: MedicineActiveColor),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget RegisterButton() {
    return InkWell(
      onTap: () async {
        if (_key.currentState.validate()) {
          setState(() => loading = true);

          var result =
              await AuthServices().regWithEmailandPass(email, pass, context);
          setState(() => loading = false);

          if (result != null) {
            setState(() => loading = true);

            FireStoreServices(uid: result).uploadUserData(
                name, phone, age, gender, country, email, bloodType);

            setState(() => loading = false);

            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: VerificationPage(userUid: result, email: email),
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
                value: gender,
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() => gender = value)),
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
                onChanged: (CountryCode x) => setState(() => country = x.name),
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
    return AutofillGroup(
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            _nameField(),
            _ageGender(),
            _bloodBox(),
            _CountryBox(),
            _emailPassword(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Container(
          height: height,
          width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitPumpingHeart(
                  color: BloodActiveColor,
                  size: 50,
                ),
                Text(
                  "Loading ... ${Emojis.smilingFace}",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        )
            :Container(
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
                      SizedBox(height: height * .21),
                      _title(),
                      SizedBox(height: 10),
                      _mainRegisterationForm(),
                      SizedBox(height: 20),
                      _phone(),
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
