import 'package:flutter/material.dart';

class AddMedicineLibrary extends StatefulWidget {
  @override
  _AddMedicineLibraryState createState() => _AddMedicineLibraryState();
}

class _AddMedicineLibraryState extends State<AddMedicineLibrary> {
  int con;
  String type ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(118, 0, 210, 1),
          title: Text("Add Medicine To Library"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(
                      color: Color.fromRGBO(210, 135, 255, 1), fontSize: 30),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(252, 243, 255, 1),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 20,
                              color: Color.fromRGBO(154, 93, 255, 1))),
                      hintText: "Medicine Name",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
                          fontSize: 27)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  color: Color.fromRGBO(252, 243, 255, 1),
                  child: DropdownButton<int>(
                      isExpanded: true,
                      value: con,
                      onChanged: (int i) => setState(() => con = i),
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
                      onTap: () => print("tabed"),
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
                        DropdownMenuItem(child: Text("100"), value: 100),
                        DropdownMenuItem(child: Text("200"), value: 200),
                        DropdownMenuItem(child: Text("300"), value: 300),
                        DropdownMenuItem(child: Text("400"), value: 400),
                        DropdownMenuItem(child: Text("500"), value: 500),
                        DropdownMenuItem(child: Text("600"), value: 600),
                        DropdownMenuItem(child: Text("700"), value: 700),
                        DropdownMenuItem(child: Text("800"), value: 800),
                        DropdownMenuItem(child: Text("900"), value: 900),
                        DropdownMenuItem(child: Text("1000"), value: 1000),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Container(
                  color: Color.fromRGBO(252, 243, 255, 1),
                  child: DropdownButton<String>(
                      isExpanded: true,
                      value: type,
                      onChanged: (String i) => setState(() => type = i),
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
                      onTap: () => print(type),
                      elevation: 2,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Medicine Type",
                          style: TextStyle(
                              color: Color.fromRGBO(210, 135, 255, 1),
                              fontSize: 27),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(child: Text("Tablets"), value: "Tablets"),
                        DropdownMenuItem(child: Text("Cream"), value: "Cream"),
                        DropdownMenuItem(child: Text("Syringe"), value: "Syringe"),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 13, top: 8),
                child: TextFormField(
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
                      hintText: "Notes",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(210, 135, 255, 1),
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
                            image: AssetImage("assets/Post Medicine Icon.png"),
                            fit: BoxFit.contain,
                          )),
                        ),
                        Text(
                          "Add",
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
              SizedBox(height: 15),
            ],
          ),
        ));
  }
}
