import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Databases/FireStore.dart';
import 'package:medicine/Medicine/MedicineMainPage.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

import 'Add_Medicine_Library.dart';

class RequestMedicinePost extends StatefulWidget {
  @override
  _RequestMedicinePostState createState() => _RequestMedicinePostState();
}

class _RequestMedicinePostState extends State<RequestMedicinePost> {
  String medicine = "";
  int concentration;
  String neededQuantity = "";
  String loc = "";
  String notes = "";
  List<String> list;

  @override
  void initState() {
    super.initState();
    setState(() {
      list = MedicinesArray.toList();
      list.removeWhere((element) => (element.length <= 3 && element[0] != "F"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(118, 0, 210, 1),
          title: Text("Request a Medicine"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Medicine
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: DropdownSearch(
                  dropdownSearchDecoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(154, 93, 255, 1.0),
                            width: 10,
                            style: BorderStyle.none)),
                    fillColor: Color.fromRGBO(252, 243, 255, 1),
                    filled: true,
                    hintText: "Medicine Name",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(210, 135, 255, 1), fontSize: 27),
                  ),
                  onChanged: (Object i) =>
                      setState(() => medicine = i.toString()),
                  dropDownButton: Container(
                    margin: EdgeInsets.only(right: 0, bottom: 5),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/MedicineDropDownIcon.png"),
                      fit: BoxFit.contain,
                    )),
                  ),
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  showSearchBox: true,
                  searchBoxDecoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(252, 243, 255, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 10,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
                          fontSize: 15)),
                  items: list,
                ),
              ),
              // Concentration
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  color: Color.fromRGBO(252, 243, 255, 1),
                  child: DropdownButton<int>(
                      isExpanded: true,
                      value: concentration,
                      onChanged: (int i) => setState(() => concentration = i),
                      style: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
                          fontSize: 27),
                      underline: Container(color: Colors.black87, height: 1),
                      icon: Container(
                        margin: EdgeInsets.only(right: 22, bottom: 5),
                        height: 50,
                        width: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/MedicineDropDownIcon.png"),
                          fit: BoxFit.contain,
                        )),
                      ),
                      elevation: 2,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Concentration",
                          style: TextStyle(
                              color: Color.fromRGBO(210, 135, 255, 1),
                              fontSize: 27),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                            child: Text("100"),
                            value: 100,
                            onTap: () => concentration = 100),
                        DropdownMenuItem(child: Text("200"), value: 200),
                        DropdownMenuItem(child: Text("300"), value: 300)
                      ]),
                ),
              ),
              // Needed Quantity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (i) => setState(() => neededQuantity = i),
                  style: TextStyle(
                      color: Color.fromRGBO(210, 135, 255, 1), fontSize: 30),
                  decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Color.fromRGBO(252, 243, 255, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              width: 10,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Needed Quantity (Optional)",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
                          fontSize: 27)),
                ),
              ),
              // Location
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                child: TextFormField(
                  onChanged: (i) => setState(() => loc = i),
                  style: TextStyle(
                      color: Color.fromRGBO(210, 135, 255, 1), fontSize: 30),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(252, 243, 255, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              width: 10,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Location (Optional)",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
                          fontSize: 27)),
                ),
              ),
              // Notes
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 13, top: 8),
                child: TextFormField(
                  onChanged: (i) => setState(() => notes = i),
                  maxLines: null,
                  style: TextStyle(
                      color: Color.fromRGBO(210, 135, 255, 1), fontSize: 30),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(252, 243, 255, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              width: 10,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Notes (Optional)",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
                          fontSize: 27)),
                ),
              ),
              SizedBox(height: 15),
              // Post Page
              InkWell(
                onTap: () async {
                  if (medicine == "") {
                    Toast.show("Please Choose Medicine", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    return;
                  }

                  if (concentration == null)
                    Toast.show("Please Choose Concentration", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  else {
                    var result = await FireStoreServices(uid: "")
                        .AddRequestPost(medicine, concentration.toString(),
                            neededQuantity, loc, notes);

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
                        color: Color.fromRGBO(118, 0, 210, 1),
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/Post Medicine Icon.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                          Text(
                            "Post",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Cannot find the medicine label
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: AddMedicineLibrary(),
                        duration: Duration(milliseconds: 500))),
                child: Text("Cannot Find your Medicine ?",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                        fontSize: 16)),
              ),
              SizedBox(height: 30)
            ],
          ),
        ));
  }
}
