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
  List<Map<String,dynamic>> list = [];
  List<Posts> post = [];

  // List<Posts> _newposts = [
  //   Posts(
  //     UserName: "Ziyad Hassan",
  //     MedicineName: "I need Minoxidil as soon as possible",
  //     Concentration: "Minoxidil",
  //     Time: "24 min ago",
  //   ),
  //   Posts(
  //     UserName: "omar yacine",
  //     MedicineName: "Could any one help me",
  //     Concentration: "Antinal",
  //     Time: "26 min ago",
  //   ),
  //   Posts(
  //     UserName: "AbdelHamid",
  //     MedicineName: "I have 8 Tablets of this medicine if anyone need it",
  //     Concentration: "Paracetamol",
  //     Time: "30 min ago",
  //   ),
  //   Posts(
  //     UserName: "Hossam",
  //     MedicineName: "Urgent please",
  //     Concentration: "Ranitidine",
  //     Time: "1 hour ago",
  //   ),
  //   Posts(
  //     UserName: "Ghareeb",
  //     MedicineName: "I have excess of this medicine if anyone need it just call me",
  //     Concentration: "Citalopram",
  //     Time: "1 hour ago",
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    read();
  }

  read() async {
    list = await FireStoreServices(uid: "").getRequestPosts();


    print("List = " + list.toString());


    // post = list.map((e) {
    //
    //  return Posts(
    //       Concentration: e.data()["Concentration"],
    //       UserName: e.data()["User Name"],
    //       MedicineName: e.data()["Medicine Name"],
    //       Notes: e.data()["Notes"],
    //       PhoneNumber: e.data()["Phone Number"],
    //       time: e.data()["Time"],
    //       Location: e.data()["Location"],
    //       NeededQuntity: e.data()["Needed Quantity"]);
    //
    // }
    // )
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
