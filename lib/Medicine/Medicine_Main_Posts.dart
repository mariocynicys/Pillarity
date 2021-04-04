import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Database/FireStore.dart';

import 'Post.dart';

class MedicineMainPosts extends StatefulWidget {
  // We should search with these parameters (if filter is applied)
  String medicine_name;
  String Catagory;

  MedicineMainPosts({this.medicine_name, this.Catagory});

  @override
  _MedicineMainPostsState createState() => _MedicineMainPostsState();
}

class _MedicineMainPostsState extends State<MedicineMainPosts> {
  List<Map<String, dynamic>> list = [];
  List<Posts> post = [];

  @override
  void initState() {
    super.initState();
    read();
  }

  read() async {
    list = await FireStoreServices(uid: "").getRequestPosts();

    setState(() {
      post = list.map(casting).toList();
    });
  }

  Posts casting(Map<String, dynamic> e) {
    return Posts(
        Concentration: e["Concentration"],
        UserName: e["User Name"],
        MedicineName: e["Medicine Name"],
        Notes: e["Notes"],
        PhoneNumber: e["Phone Number"],
        time: (e["Time"] as Timestamp).toDate(),
        Location: e["Location"],
        NeededQuntity: e["Needed Quantity"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
      ),
      body: RefreshIndicator(
        onRefresh: () => read(),
        child: (post.length != 0)
            ? ListView.builder(
                itemCount: post.length,
                itemBuilder: (context, index) => post[index])
            : ListView(
                children: [
                  Center(
                    child: Text("No Posts"),
                  ),
                ],
              ),
      ),
    );
  }
}
