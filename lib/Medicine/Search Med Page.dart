import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Databases/FireStore.dart';

import 'Post.dart';

class SearchPage extends StatefulWidget {
  final String medName;

  SearchPage({@required this.medName});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> list = [];
  List<Posts> post = [];
  String lastUID = "";
  Timestamp lastPostTime;
  bool noMorePosts = false;
  bool gettingPosts = false;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    getPosts();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent)
        getMorePosts();
    });
  }

  getPosts() async {
    setState(() => gettingPosts = true);

    if (widget.medName.length <= 3 && widget.medName[0] != "f")
      list = await FireStoreServices(uid: "").searchBloodPosts(widget.medName);
    else
      list =
          await FireStoreServices(uid: "").searchMedicinePosts(widget.medName);

    if (list.length < 10)
      setState(() => noMorePosts = true);
    else
      setState(() => noMorePosts = false);

    setState(() {
      post = list.map(casting).toList();
      gettingPosts = false;

      // Adding Temp post for last object The Text
      post.add(Posts(
        Concentration: "Concentration",
        UserName: "UserName",
        UID: "UID",
        MedicineName: "MedicineName",
        Notes: "Notes",
        PhoneNumber: "PhoneNumber",
        PostTime: DateTime(1),
        Type: "Type",
        Location: "Location",
        NeededQuntity: "NeededQuntity",
        BloodType: '',
        ExpirationDate: DateTime(1),
      ));
    });
  }

  getMorePosts() async {
    if (gettingPosts) return;
    setState(() => gettingPosts = true);

    if (widget.medName.length <= 3 && widget.medName[0] != "f")
      list = await FireStoreServices(uid: "")
          .getMoreSearchBloodPosts(widget.medName, lastPostTime);
    else
      list = await FireStoreServices(uid: "")
          .getMoreSearchMedicinePosts(widget.medName, lastPostTime);

    if (list.length < 10)
      setState(() => noMorePosts = true);
    else
      setState(() => noMorePosts = false);

    setState(() {
      post.removeAt(post.length - 1);
      post.addAll(list.map(casting).toList());

      // Adding Temp post for last object The Text
      post.add(Posts(
        Concentration: "Concentration",
        UserName: "UserName",
        UID: "UID",
        MedicineName: "MedicineName",
        Notes: "Notes",
        PhoneNumber: "PhoneNumber",
        PostTime: DateTime(1),
        Location: "Location",
        NeededQuntity: "NeededQuntity",
        Type: "",
        ExpirationDate: DateTime(1),
        BloodType: '',
      ));
      gettingPosts = false;
    });
  }

  Posts casting(Map<String, dynamic> e) {
    lastUID = e["UID"];
    lastPostTime = e["Time"];
    if (e["Type"] == "Request Medicine")
      return Posts(
        Concentration: e["Concentration"],
        UserName: e["User Name"],
        UID: e["UID"],
        MedicineName: e["Medicine Name"],
        Notes: e["Notes"],
        PhoneNumber: e["Phone Number"],
        PostTime: (e["Time"] as Timestamp).toDate(),
        Type: e["Type"],
        Location: e["Location"],
        NeededQuntity: e["Needed Quantity"],
        ExpirationDate: DateTime(1),
        BloodType: "",
      );
    else if (e["Type"] == "Giving Medicine")
      return Posts(
        Concentration: e["Concentration"],
        UserName: e["User Name"],
        UID: e["UID"],
        MedicineName: e["Medicine Name"],
        Notes: e["Notes"],
        PhoneNumber: e["Phone Number"],
        PostTime: (e["Time"] as Timestamp).toDate(),
        Type: e["Type"],
        Location: e["Location"],
        NeededQuntity: e["Quantity"],
        BloodType: '',
        ExpirationDate: (e["Expiration Date"] as Timestamp).toDate(),
      );
    else
      return Posts(
        Concentration: "",
        UserName: e["User Name"],
        UID: e["UID"],
        MedicineName: "",
        Notes: e["Notes"],
        PhoneNumber: e["Phone Number"],
        PostTime: (e["Time"] as Timestamp).toDate(),
        Type: e["Type"],
        Location: e["Location"],
        NeededQuntity: e["Quantity"],
        BloodType: e["Blood Type"],
        ExpirationDate: DateTime(1),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results For ${widget.medName.toUpperCase()}"),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
      ),
      body: RefreshIndicator(
        onRefresh: () => getPosts(),
        child: ListView.builder(
            controller: _controller,
            itemCount: post.length,
            itemBuilder: (context, index) {
              if (index == post.length - 1) if (noMorePosts)
                return Container(
                  height: 70,
                  child: Center(
                      child: Text(
                    "No more Posts ${Emojis.brokenHeart}",
                    style: TextStyle(fontSize: 20),
                  )),
                );
              else
                return Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(),
                      Text("Wait, You can help more People ${Emojis.redHeart}"),
                    ],
                  ),
                );
              else
                return post[index];
            }),
      ),
    );
  }
}
