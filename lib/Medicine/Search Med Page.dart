import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine/Database/FireStore.dart';
import 'package:page_transition/page_transition.dart';

import 'Post.dart';

class SearchPage extends StatefulWidget {
  String medName;

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

    list = await FireStoreServices(uid: "").searchPosts(widget.medName);

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

    list = await FireStoreServices(uid: "").getMoreSearchPosts(widget.medName,lastPostTime);

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
        title: Text("Results For ${widget.medName}"),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
      ),
      body: RefreshIndicator(
        onRefresh: () => getPosts(),
        child: (post.length != 0)
            ? ListView.builder(
            controller: _controller,
            itemCount: post.length,
            itemBuilder: (context, index) {
              if (index == post.length - 1) if (noMorePosts)
                return Container(
                  height: 70,
                  child: Center(
                      child: Text(
                        "No more Posts ${Emojis.cryingFace}",
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
                      Text(
                          "Wait, You can help more People ${Emojis.redHeart}"),
                    ],
                  ),
                );
              else
                return post[index];
            })
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
