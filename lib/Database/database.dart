import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseServices
{
  String uid;
  DatabaseServices({@required this.uid});
  CollectionReference userData = FirebaseFirestore.instance.collection("userData");

  Future uploadUserData(String name , String phonenumber , int age , String gender)
  async{
    return await userData.doc(uid).set({
      "Name" : name ,
      "Phonenumber" : phonenumber,
      "Age" : age,
      "Gender" : gender
    });
  }

  Future getPosts()
  async{

    DocumentReference data = userData.doc(uid);
    data.get().then((value) {
     String name = value.data()['Name'];
    });
  }

}