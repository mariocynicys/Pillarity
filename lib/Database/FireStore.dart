import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine/Auth/auth.dart';

import '../DataBase.dart';

class FireStoreServices {
  String uid;
  String Name = "Name";
  String Age = "Age";
  String BloodType = "BloodType";
  String Gender = "Gender";
  String Phone = "Phone";
  String Loaction = "Loaction";
  String Email = "Email";

  FireStoreServices({@required this.uid});

  CollectionReference userData =
      FirebaseFirestore.instance.collection("UsersData");

  CollectionReference Posts = FirebaseFirestore.instance.collection("Posts");

  Future uploadUserData(String name, String phonenumber, String age,
      String gender, String country, String email, String bloodType) async {
    return await userData.doc(uid).set({
      Name: name,
      Phone: phonenumber,
      Age: age,
      Gender: gender,
      Loaction: country,
      Email: email,
      BloodType: bloodType
    });
  }

  Future<DocumentSnapshot> getUserData() async {
    return await userData.doc(uid).get();
  }

  Future AddRequestPost(String Medicine_Name, String Concentration,
      String Needed_Quantity, String Location, String Notes) async {

    List<Map<String, dynamic>> list = await DataBaseHelper.instance.getInfo();
    DateTime time = DateTime.now();

    return await Posts.add({
      "UID": list[0][DataBaseHelper().UID],
      "Type":"Request Medicine",
      "User Name": list[0][DataBaseHelper().Name],
      "Phone Number": list[0][DataBaseHelper().Phone],
      "Medicine Name": Medicine_Name,
      "Concentration": Concentration,
      "Needed Quantity": Needed_Quantity,
      "Location": Loaction,
      "Notes": Notes,
      "Time" :time
    });
  }

  Future<List<Map<String,dynamic>>> getRequestPosts() async {
    QuerySnapshot data =
        await Posts.orderBy("Time",descending: true).limit(2).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
