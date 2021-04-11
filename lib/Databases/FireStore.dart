import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Local_DataBase.dart';

class FireStoreServices {
  String uid;
  String Name = "Name";
  String Age = "Age";
  String BloodType = "BloodType";
  String Gender = "Gender";
  String Phone = "Phone";
  String Loaction = "Location";
  String Email = "Email";

  FireStoreServices({@required this.uid});

  CollectionReference userData =
      FirebaseFirestore.instance.collection("UsersData");

  CollectionReference Posts = FirebaseFirestore.instance.collection("Posts");

  CollectionReference Library = FirebaseFirestore.instance.collection("Library");

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
      String Needed_Quantity, String Loc, String notes) async {
    List<Map<String, dynamic>> list = await DataBaseHelper.instance.getInfo();
    DateTime time = DateTime.now();

    return await Posts.add({
      "UID": list[0][DataBaseHelper().UID],
      "Type": "Request Medicine",
      "User Name": list[0][DataBaseHelper().Name],
      "Phone Number": list[0][DataBaseHelper().Phone],
      "Medicine Name": Medicine_Name.toLowerCase(),
      "Concentration": Concentration,
      "Needed Quantity": Needed_Quantity,
      "Location": Loc,
      "Notes": notes,
      "Time": time
    });
  }

  Future AddGivingPost(
      String Medicine_Name,
      String Concentration,
      String Quantity,
      String Loc,
      String notes,
      DateTime ExpirationDate) async {
    List<Map<String, dynamic>> list = await DataBaseHelper.instance.getInfo();
    DateTime time = DateTime.now();

    return await Posts.add({
      "UID": list[0][DataBaseHelper().UID],
      "Type": "Giving Medicine",
      "User Name": list[0][DataBaseHelper().Name],
      "Phone Number": list[0][DataBaseHelper().Phone],
      "Medicine Name": Medicine_Name.toLowerCase(),
      "Concentration": Concentration,
      "Quantity": Quantity,
      "Expiration Date": ExpirationDate,
      "Location": Loc,
      "Notes": notes,
      "Time": time
    });
  }

  Future AddBloodPost(
    String BloodType,
    String Quantity,
    String Loc,
    String notes,
  ) async {
    List<Map<String, dynamic>> list = await DataBaseHelper.instance.getInfo();
    DateTime time = DateTime.now();

    return await Posts.add({
      "UID": list[0][DataBaseHelper().UID],
      "Type": "Blood Donation",
      "User Name": list[0][DataBaseHelper().Name],
      "Phone Number": list[0][DataBaseHelper().Phone],
      "Quantity": Quantity,
      "Blood Type": BloodType.toLowerCase(),
      "Location": Loc,
      "Notes": notes,
      "Time": time
    });
  }

  Future AddMedicineToLibrary(
      String medicineName,
      String concentration,
      String type,
      String notes,
      ) async {
    List<Map<String, dynamic>> list = await DataBaseHelper.instance.getInfo();
    DateTime time = DateTime.now();

    return await Library.add({
      "UID": list[0][DataBaseHelper().UID],
      "Medicine Name" : medicineName,
      "Concentration" : concentration,
      "Type": type,
      "Notes": notes,
      "Country" : list[0][DataBaseHelper().Location],
      "Time": time
    });
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    try {
      QuerySnapshot data =
          await Posts.orderBy("Time", descending: true).limit(10).get();
      return data.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("the error = " + e.toString());
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getMorePosts(
      String lastUID, Timestamp time) async {
    QuerySnapshot data = await Posts.orderBy("Time", descending: true)
        .startAfter([time])
        .limit(10)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> searchMedicinePosts(String med) async {
    QuerySnapshot data = await Posts.orderBy("Time", descending: true)
        .where("Medicine Name", isEqualTo: med)
        .limit(10)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> searchBloodPosts(String bloodType) async {
    QuerySnapshot data = await Posts.orderBy("Time", descending: true)
        .where("Blood Type", isEqualTo: bloodType)
        .limit(10)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getMoreSearchMedicinePosts(
      String med, Timestamp time) async {
    QuerySnapshot data = await Posts.orderBy("Time", descending: true)
        .where("Medicine Name", isEqualTo: med)
        .startAfter([time])
        .limit(10)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getMoreSearchBloodPosts(
      String bloodType, Timestamp time) async {
    QuerySnapshot data = await Posts.orderBy("Time", descending: true)
        .where("Blood Type", isEqualTo: bloodType)
        .startAfter([time])
        .limit(10)
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}
