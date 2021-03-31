import 'package:flutter/material.dart';
import 'package:medicine/Auth/auth.dart';
import 'package:medicine/DataBase.dart';
import 'package:medicine/Models/UserModel.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:medicine/WelcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String blood_type = "A+";
  String name = "Ahmed Mohamed";
  String phone_num = "01211202111";
  String location = "Egypt";
  String email = "Ahmed@gmail.com";
  List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();
    read();
  }

  read() async {
    list = await DataBaseHelper.instance.GetAllInfo();
    if (list != null && list.length != 0) {
      name = list[0][DataBaseHelper.instance.Name];
      phone_num = list[0][DataBaseHelper.instance.Phone];
      location = list[0][DataBaseHelper.instance.Loaction];
      email = list[0][DataBaseHelper.instance.Email];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Profile.png'),
                  radius: 60.0,
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
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
              //SizedBox(height: 10.0),
              Text(
                'NAME',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                '$name',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 22.0,
                  // fontFamily: 'IndieFlower',
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Blood Type',
                style: TextStyle(
                  fontSize: 21.0,
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                '$blood_type',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                ),
              ),

              SizedBox(height: 15.0),
              Text(
                'Phone Number :',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                '$phone_num',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'location :',
                style: TextStyle(
                  color: Color.fromRGBO(154, 93, 255, 1.0),
                  letterSpacing: 2.0,
                  fontSize: 21.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                '$location',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 15.0),
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,

              Text(
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
                Text(
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
                  onPressed: () {
                    var result = AuthServices().SignOut();
                    if (result != null) {
                      DataBaseHelper.instance.delete(0);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    } else
                      Toast.show("Something Went Wrong", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                        child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
          //       child: RaisedButton(
          //         onPressed: () {},
          //         textColor: Colors.amber,
          //         color: Colors.redAccent,
          //         child: Text('reset'),
          //       ),
          //     )
          //   ],
          // )
          // SizedBox(height: 40.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     CircleAvatar(
          //       backgroundImage: AssetImage('assets/bat.png'),
          //       radius: 20.0,
          //     ),
          //     CircleAvatar(
          //       backgroundImage: AssetImage('assets/bat.png'),
          //       radius: 20.0,
          //     ),
          //     CircleAvatar(
          //       backgroundImage: AssetImage('assets/bat.png'),
          //       radius: 20.0,
          //     ),
          //   ],
          // )
        ),
      ),
    );
  }
}
