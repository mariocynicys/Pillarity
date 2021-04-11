import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine/Databases/FireStore.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:page_transition/page_transition.dart';
import 'Post.dart';
import 'Search Med Page.dart';

class MedicineMainPosts extends StatefulWidget {
  // We should search with these parameters (if filter is applied)
  final String medicineName;
  final String category;

  MedicineMainPosts({this.medicineName, this.category});

  @override
  _MedicineMainPostsState createState() => _MedicineMainPostsState();
}

class _MedicineMainPostsState extends State<MedicineMainPosts> {
  List<Map<String, dynamic>> list = [];
  List<Posts> posts = [];
  String lastUID = "";
  Timestamp lastPostTime;
  bool noMorePosts = false;
  bool gettingPosts = false;
  bool refreshing = false;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    if (posts.length == 0) getPosts();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent)
        getMorePosts();
    });
  }

  getPosts() async {
    setState(() => gettingPosts = true);

    list = await FireStoreServices(uid: "").getPosts();

    if (list.length < 10)
      setState(() => noMorePosts = true);
    else
      setState(() => noMorePosts = false);

    setState(() {
      posts = list.map(casting).toList();
      setState(() => gettingPosts = false);

      // Adding Temp post for last object The Text (Loading object)
      posts.add(Posts(
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
    if (gettingPosts || refreshing) return;

    setState(() => gettingPosts = true);
    print("Getting more posts");

    list = await FireStoreServices(uid: "").getMorePosts(lastUID, lastPostTime);

    if (list.length < 10)
      setState(() => noMorePosts = true);
    else
      setState(() => noMorePosts = false);

    setState(() {
      posts.removeAt(posts.length - 1);
      posts.addAll(list.map(casting).toList());

      // Adding Temp post for last object The Text
      posts.add(Posts(
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

  refreshPosts() async {
    if (refreshing || gettingPosts) return;

    setState(() => refreshing = true);
    list = await FireStoreServices(uid: "").getPosts();

    setState(() {
      int i = 0;
      while (list.isNotEmpty && i < list.length) {
        Posts temp = posts.firstWhere((element) =>
            element.UID == list[i]["UID"] &&
            element.PostTime == (list[i]["Time"] as Timestamp).toDate());
        if (temp != null) {
          print("here");
          list.remove(list[i]);
        } else
          i++;
      }

      for (int j = 0; j < list.length; j++) posts.insert(0, casting(list[j]));

      refreshing = false;
    });
  }

  Posts casting(Map<String, dynamic> e) {
    // We don't want to change the last uid if we are refreshing
    if (!refreshing) {
      lastUID = e["UID"];
      lastPostTime = e["Time"];
    }
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
        title: Text("Posts"),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshPosts(),
        child: ListView.builder(
            controller: _controller,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              if (index == posts.length - 1) if (noMorePosts)
                return Container(
                  height: 70,
                  child: Center(
                      child: Text(
                    "No Posts ${Emojis.brokenHeart}",
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
                      SizedBox(width: 15),
                      Text("Wait, You can help more People ${Emojis.redHeart}"),
                    ],
                  ),
                );
              else
                return posts[index];
            }),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, "");
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // we should have list from his search history in the database
    final suggestions = MedicinesArray.where(
            (element) => element.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // We should add the search result text to his history in the database
          // may be we don't need buildResults function and go to MedicineResultPage
          query = suggestions[index].toLowerCase();

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: SearchPage(medName: query),
                  duration: Duration(milliseconds: 1000)));
        },
        // There is only one medicine that its length is <= 3
        leading: suggestions[index].length <= 3 && suggestions[index][0] != "F"
            ? Icon(
                IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null),
                color: BloodActiveColor)
            : FaIcon(FontAwesomeIcons.pills, color: Colors.blueAccent),
        title: RichText(
          text: TextSpan(
              text: suggestions[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestions[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
    );
  }
}
