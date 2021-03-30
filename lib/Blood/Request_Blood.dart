import 'package:flutter/material.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  String con;
  String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(188, 0, 113, 1),
          title: Text("Request Blood"),
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
                      value: con,
                      onChanged: (String i) => setState(() => con = i),
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
                      onTap: () => print("tabbed"),
                      elevation: 2,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Needed Quantity",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 133, 155, 1),
                              fontSize: 27),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                            child: Text("0.1 Litre"), value: "100"),
                        DropdownMenuItem(
                            child: Text("0.2 Litre"), value: "200"),
                        DropdownMenuItem(
                            child: Text("0.3 Litre"), value: "300"),
                        DropdownMenuItem(
                            child: Text("0.4 Litre"), value: "400"),
                        DropdownMenuItem(
                            child: Text("0.5 Litre"), value: "500"),
                        DropdownMenuItem(
                            child: Text("0.6 Litre"), value: "600"),
                        DropdownMenuItem(
                            child: Text("0.7 Litre"), value: "700"),
                        DropdownMenuItem(
                            child: Text("0.8 Litre"), value: "800"),
                        DropdownMenuItem(
                            child: Text("0.9 Litre"), value: "900"),
                        DropdownMenuItem(child: Text("1 Litre"), value: "1000"),
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
                        child: Text(
                          "Blood Type",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 133, 155, 1),
                              fontSize: 27),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(child: Text("A-"), value: "A-"),
                        DropdownMenuItem(child: Text("A+"), value: "A+"),
                        DropdownMenuItem(child: Text("B-"), value: "B-"),
                        DropdownMenuItem(child: Text("B+"), value: "B+"),
                        DropdownMenuItem(child: Text("AB-"), value: "AB-"),
                        DropdownMenuItem(child: Text("AB+"), value: "AB+"),
                        DropdownMenuItem(child: Text("O-"), value: "O-"),
                        DropdownMenuItem(child: Text("O+"), value: "O+"),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 8),
                child: TextFormField(
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
              Padding(
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
                          child: Text(
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
              SizedBox(height: 15),
            ],
          ),
        ));
  }
}
