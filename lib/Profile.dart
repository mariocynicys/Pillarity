import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String blood_type = "A+";
  String name = 'Ahmed Mohamed';
  String phone_num = '01127010091';
  String location = 'Maadi Cairo Egypt';

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
                  'Ahmedmohamed@gmail.com',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18.0,
                      letterSpacing: 1.0),
                )
              ]),
              SizedBox(height: 20.0),
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
