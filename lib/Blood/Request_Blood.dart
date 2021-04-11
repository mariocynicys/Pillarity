import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Databases/FireStore.dart';
import 'package:medicine/Medicine/MedicineMainPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  String quantity = "0.5 Litre";
  String type = "A+";
  String loc = "";
  String notes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(188, 0, 113, 1),
          title: AutoSizeText("Request Blood"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  color: Color.fromRGBO(252, 244, 248, 1),
                  child: DropdownButton<String>(
                      isExpanded: true,
                      value: quantity,
                      onChanged: (String i) => setState(() => quantity = i),
                      style: TextStyle(
                          color: Color.fromRGBO(255, 133, 155, 1),
                          fontSize: 27),
                      underline: Container(color: Colors.black87, height: 1),
                      icon: Container(
                        margin: EdgeInsets.only(right: 22, bottom: 5),
                        height: 50,
                        width: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/BloodDropDownIcon.png"),
                          fit: BoxFit.contain,
                        )),
                      ),
                      elevation: 2,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: AutoSizeText(
                          "Needed Quantity",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 133, 155, 1),
                              fontSize: 27),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                            child: AutoSizeText("0.1 Litre"), value: "0.1 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.2 Litre"), value: "0.2 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.3 Litre"), value: "0.3 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.4 Litre"), value: "0.4 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.5 Litre"), value: "0.5 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.6 Litre"), value: "0.6 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.7 Litre"), value: "0.7 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.8 Litre"), value: "0.8 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("0.9 Litre"), value: "0.9 Litre"),
                        DropdownMenuItem(
                            child: AutoSizeText("1 Litre"), value: "1 Litre"),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  color: Color.fromRGBO(252, 244, 248, 1),
                  child: DropdownButton<String>(
                      isExpanded: true,
                      value: type,
                      onChanged: (String i) => setState(() => type = i),
                      style: TextStyle(
                          color: Color.fromRGBO(255, 133, 155, 1),
                          fontSize: 27),
                      underline: Container(color: Colors.black87, height: 1),
                      icon: Container(
                        margin: EdgeInsets.only(right: 22, bottom: 5),
                        height: 50,
                        width: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/BloodDropDownIcon.png"),
                          fit: BoxFit.contain,
                        )),
                      ),
                      onTap: () => print(type),
                      elevation: 2,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: AutoSizeText(
                          "Blood Type",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 133, 155, 1),
                              fontSize: 27),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(child: AutoSizeText("A-"), value: "A-"),
                        DropdownMenuItem(child: AutoSizeText("A+"), value: "A+"),
                        DropdownMenuItem(child: AutoSizeText("B-"), value: "B-"),
                        DropdownMenuItem(child: AutoSizeText("B+"), value: "B+"),
                        DropdownMenuItem(child: AutoSizeText("AB-"), value: "AB-"),
                        DropdownMenuItem(child: AutoSizeText("AB+"), value: "AB+"),
                        DropdownMenuItem(child: AutoSizeText("O-"), value: "O-"),
                        DropdownMenuItem(child: AutoSizeText("O+"), value: "O+"),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 8),
                child: TextFormField(
                  onChanged: (String i) => setState(() => loc = i),
                  style: TextStyle(
                      color: Color.fromRGBO(255, 133, 155, 1), fontSize: 30),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(252, 244, 248, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              width: 10,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Location (Optional)",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(255, 133, 155, 1),
                          fontSize: 27)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 13, top: 8),
                child: TextFormField(
                  onChanged: (String i) => setState(() => notes = i),
                  maxLines: null,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 133, 155, 1), fontSize: 30),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(252, 244, 248, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              width: 10,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Notes",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(255, 133, 155, 1),
                          fontSize: 27)),
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  print(loc);
                    var result = await FireStoreServices(uid: "")
                        .AddBloodPost(type, quantity, loc, notes);

                    if (result == null)
                      Toast.show("Cannot add Right now", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    else {

                      Toast.show("Your Request is added Successfully ", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: MedicineMainPage(),
                              duration: Duration(milliseconds: 500)));
                    }

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(188, 0, 113, 1),
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 35,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Post Blood Icon.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: AutoSizeText(
                              "Post",
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ));
  }
}
