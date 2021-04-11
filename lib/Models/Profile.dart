import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Auth/auth.dart';
import '../Databases/Local_DataBase.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:medicine/WelcomePage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Error";
  String blood_type = "Error";
  String phone_num = "Error";
  String location = "Error";
  String email = "Error";
  List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();
    read();
  }

  read() async {
    list = await DataBaseHelper.instance.getInfo();

    if (list != null && list.length != 0)
      setState(() {
        name = list[0][DataBaseHelper().Name];
        blood_type = list[0][DataBaseHelper().BloodType];
        phone_num = list[0][DataBaseHelper().Phone];
        location = list[0][DataBaseHelper().Location];
        email = list[0][DataBaseHelper().Email];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: AutoSizeText('Profile'),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Profile.png'),
                  radius: 60.0,
                ),
              ),
              SizedBox(height: 10.0),
              // Name
              Center(
                child: AutoSizeText(
                  '$name',
                  style: TextStyle(
                    color: Color.fromRGBO(154, 93, 255, 1.0),
                    letterSpacing: 2.0,
                    fontSize: 25.0,
                    // fontFamily: 'IndieFlower',
                  ),
                ),
              ),

              Divider(
                height: 40.0,
                color: Color.fromRGBO(154, 93, 255, 1.0),
              ),
              // Name
              AutoSizeText(
                'NAME',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              AutoSizeText(
                '$name',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 22.0,
                  // fontFamily: 'IndieFlower',
                ),
              ),
              SizedBox(height: 10.0),
              // Blood Type
              AutoSizeText(
                'Blood Type',
                style: TextStyle(
                  fontSize: 21.0,
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 5.0),
              AutoSizeText(
                '$blood_type',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 15.0),
              // Phone Number
              AutoSizeText(
                'Phone Number :',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              AutoSizeText(
                '$phone_num',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 15.0),
              //Location
              AutoSizeText(
                'Location :',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              AutoSizeText(
                '$location',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 15.0),
              // Email
              AutoSizeText(
                'Email :',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              Row(children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 10.0),
                AutoSizeText(
                  email,
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18.0,
                      letterSpacing: 1.0),
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: ()async {
                    var result = await AuthServices().signOut();
                    if (result != null) {
                      DataBaseHelper.instance.deleteInfoTable();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: MedicineActiveColor,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    height: 50,
                    width: 120,
                    child: Center(
                        child: AutoSizeText(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
