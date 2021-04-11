import 'package:auto_size_text/auto_size_text.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:url_launcher/url_launcher.dart';

class Posts extends StatefulWidget {
  final String UserName;
  final String UID;
  final String MedicineName;
  final String Concentration;
  final String Location;
  final String NeededQuntity;
  final String Notes;
  final String PhoneNumber;
  final String Type;
  final String BloodType;
  final DateTime ExpirationDate;
  final DateTime PostTime;

  Posts(
      {@required this.Concentration,
        @required this.UserName,
        @required this.UID,
        @required this.MedicineName,
        @required this.Notes,
        @required this.PhoneNumber,
        @required this.PostTime,
        @required this.ExpirationDate,
        @required this.BloodType,
        @required this.Type,
        @required this.Location,
        @required this.NeededQuntity});

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  String time = "";
  Color activeColor = MedicineActiveColor;
  String url = "";
  String ExpirationDate;

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.Type == "Request Medicine") {
        activeColor = MedicineActiveColor;
        url =
        'sms:+${widget.PhoneNumber}?body= Hi, ${widget.UserName} \n i see your post about requesting ${widget.MedicineName} medicine, i have excess of that medicine , i can meet you at the location you mentioned in the post ,please contact me to arrange the meeting time.';
      } else if (widget.Type == "Giving Medicine") {
        activeColor = Colors.green;
        url =
        'sms:+${widget.PhoneNumber}?body= Hi, ${widget.UserName} \n i see your post about donating ${widget.MedicineName} medicine, i really need that medicine , i can meet you at the location you mentioned in the post ,please contact me to arrange the meeting time.';
      } else {
        activeColor = BloodActiveColor;
        url =
        'sms:+${widget.PhoneNumber}?body= Hi, ${widget.UserName} \n i see your post about donating/requesting ${widget.BloodType} Blood, i can meet you at the location you mentioned in the post ,please contact me to arrange the meeting time.';
        ExpirationDate =
            DateFormat('dd-MM-yyyy').format(widget.ExpirationDate).toString();
      }
    });

    setState(() {
      if (DateTime.now().difference(widget.PostTime).inDays != 0) {
        time = "${DateTime.now().difference(widget.PostTime).inDays} Days ago";
      } else if (DateTime.now().difference(widget.PostTime).inHours != 0) {
        time =
        "${DateTime.now().difference(widget.PostTime).inHours} Hours ago";
      } else {
        time =
        "${DateTime.now().difference(widget.PostTime).inMinutes} Min ago";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget RequestMedicinePost() {
    return Material(
      color: Colors.grey,
      elevation: 14,
      // borderRadius: BorderRadius.circular(12),
      shadowColor: Color(0x802196F3),
      child: Card(
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              height: 10,
              color: Colors.grey,
            ),
            ListTile(
              title: AutoSizeText("${widget.UserName}"),
              subtitle: AutoSizeText(
                "#Request Medicine",
                style: TextStyle(color: activeColor),
              ),
              trailing: AutoSizeText(time),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/Profile.png'),
                radius: 20.0,
              ),
            ),
            Divider(
              height: 10.0,
              color: Color.fromRGBO(154, 93, 255, 1.0),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Column(
                  children: [
                    Row(children: [
                      Tooltip(
                        message: "Concentration",
                        verticalOffset: 12,
                        height: 12,
                        child: Image(
                          image: AssetImage('assets/pills.png'),
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.MedicineName.toUpperCase()}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      // Image(
                      //   image: AssetImage('assets/tube.png'),
                      //   width: 30.0,
                      //   height: 30.0,
                      // ),
                      Tooltip(
                        message: "Concentration",
                        verticalOffset: 12,
                        height: 12,
                        child: Image(
                          image: AssetImage('assets/conen.png'),
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.Concentration}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      Tooltip(
                        message: "Amout Needed",
                        verticalOffset: 12,
                        height: 12,
                        child: Image(
                          image: AssetImage('assets/amount.png'),
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.NeededQuntity}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      Icon(
                        Icons.location_on,
                        color: activeColor,
                        size: 25.0,
                      ),
                      AutoSizeText(
                        " : ${widget.Location}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(height: 20.0),
                    Row(children: [
                      Tooltip(
                        message: "Extra Info",
                        verticalOffset: 12,
                        height: 12,
                        child: Icon(
                          Icons.info,
                          color: activeColor,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.Notes}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      height: 0.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                  ],
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                onPressed: () async {
                  launch(('tel://${widget.PhoneNumber}'));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  //width: MediaQuery.of(context).size.width,
                  //color: Color.fromRGBO(203, 0, 254, 1),

                  child: Column(children: [
                    Divider(
                      height: 10.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Contact",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25, color: activeColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.phone_enabled,
                          color: activeColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await launch(
                      (url)); //7ot valid phone number widget.PhoneNumber
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  //width: MediaQuery.of(context).size.width,
                  //color: Color.fromRGBO(203, 0, 254, 1),

                  child: Column(children: [
                    Divider(
                      height: 10.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          "SMS",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25, color: activeColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.message,
                          color: activeColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
            Container(height: 0, color: Colors.grey),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget GivingMedicinePost() {
    return Material(
      color: Colors.grey,
      elevation: 14,
      // borderRadius: BorderRadius.circular(12),
      shadowColor: Color(0x802196F3),
      child: Card(
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              height: 10,
              color: Colors.grey,
            ),
            ListTile(
              title: AutoSizeText("${widget.UserName}"),
              subtitle: AutoSizeText(
                "#Medicine Donation",
                style: TextStyle(color: activeColor),
              ),
              trailing: AutoSizeText(time),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/Profile.png'),
                radius: 20.0,
              ),
            ),
            Divider(
              height: 10.0,
              color: Color.fromRGBO(154, 93, 255, 1.0),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Column(
                  children: [
                    Row(children: [
                      AutoSizeText(
                        "${Emojis.pill} : ${widget.MedicineName.toUpperCase()}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(children: [
                      Tooltip(
                        message: "Concentration",
                        verticalOffset: 12,
                        height: 12,
                        child: Image(
                          image: AssetImage('assets/conen.png'),
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.Concentration}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      Icon(
                        Icons.location_on,
                        color: activeColor,
                      ),
                      AutoSizeText(
                        " : ${widget.Location}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(height: 20.0),
                    Row(children: [
                      Tooltip(
                        message: "Amount Needed",
                        verticalOffset: 12,
                        height: 12,
                        child: Image(
                          image: AssetImage('assets/amount.png'),
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.NeededQuntity} Tablets",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(height: 20.0),
                    Row(children: [
                      Tooltip(
                        message: "Extra Info",
                        verticalOffset: 12,
                        height: 12,
                        child: Icon(
                          Icons.info,
                          color: activeColor,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.Notes}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(height: 20.0),
                    Divider(
                      height: 0.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                  ],
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                onPressed: () async {
                  launch(('tel://${widget.PhoneNumber}'));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  //width: MediaQuery.of(context).size.width,
                  //color: Color.fromRGBO(203, 0, 254, 1),

                  child: Column(children: [
                    Divider(
                      height: 10.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Contact",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25, color: activeColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.phone_enabled,
                          color: activeColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await launch(
                      (url)); //7ot valid phone number widget.PhoneNumber
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  //width: MediaQuery.of(context).size.width,
                  //color: Color.fromRGBO(203, 0, 254, 1),

                  child: Column(children: [
                    Divider(
                      height: 10.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          "SMS",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25, color: activeColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.message,
                          color: activeColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
            Container(height: 0, color: Colors.grey),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget BloodDonationPost() {
    return Material(
      color: Colors.grey,
      elevation: 14,
      // borderRadius: BorderRadius.circular(12),
      shadowColor: Color(0x802196F3),
      child: Card(
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              height: 10,
              color: Colors.grey,
            ),
            ListTile(
              title: AutoSizeText("${widget.UserName}"),
              subtitle: AutoSizeText(
                "#Blood Donation",
                style: TextStyle(color: activeColor),
              ),
              trailing: AutoSizeText(time),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/Profile.png'),
                radius: 20.0,
              ),
            ),
            Divider(
              height: 10.0,
              color: Color.fromRGBO(154, 93, 255, 1.0),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Column(
                  children: [
                    Row(children: [
                      Tooltip(
                        message: "Blood Type",
                        verticalOffset: 12,
                        height: 12,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Icon(
                            const IconData(0xe800,
                                fontFamily: 'MyFlutterApp', fontPackage: null),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.BloodType.toUpperCase()}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Tooltip(
                        message: "Amout Needed",
                        verticalOffset: 12,
                        height: 12,
                        child: Image(
                          image: AssetImage('assets/bloodamount.png'),
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.NeededQuntity}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Tooltip(
                          message: "Location",
                          verticalOffset: 12,
                          height: 12,
                          child: Icon(
                            Icons.location_on,
                            color: activeColor,
                          ),
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.Location}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(height: 20.0),
                    Row(children: [
                      Tooltip(
                        message: "Extra Info",
                        verticalOffset: 12,
                        height: 12,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Icon(
                            Icons.info,
                            color: activeColor,
                          ),
                        ),
                      ),
                      AutoSizeText(
                        " : ${widget.Notes}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      height: 0.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                  ],
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                onPressed: () async {
                  launch(('tel://${widget.PhoneNumber}'));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  //width: MediaQuery.of(context).size.width,
                  //color: Color.fromRGBO(203, 0, 254, 1),

                  child: Column(children: [
                    Divider(
                      height: 10.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Contact",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25, color: activeColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.phone_enabled,
                          color: activeColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await launch(
                      (url)); //7ot valid phone number widget.PhoneNumber
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  //width: MediaQuery.of(context).size.width,
                  //color: Color.fromRGBO(203, 0, 254, 1),

                  child: Column(children: [
                    Divider(
                      height: 10.0,
                      color: Color.fromRGBO(154, 93, 255, 1.0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          "SMS",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25, color: activeColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.message,
                          color: activeColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
            Container(height: 0, color: Colors.grey),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.Type == "Request Medicine")
      return RequestMedicinePost();
    else if (widget.Type == "Giving Medicine")
      return GivingMedicinePost();
    else
      return BloodDonationPost();
  }
}
