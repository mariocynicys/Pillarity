import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine/Database/FireStore.dart';
import 'package:page_transition/page_transition.dart';

import 'Post.dart';
import 'Search Med Page.dart';

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

    list = await FireStoreServices(uid: "").getRequestPosts();

    if (list.length < 10) setState(() => noMorePosts = true);
    else setState(() => noMorePosts = false);


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
          time: DateTime(1),
          Location: "Location",
          NeededQuntity: "NeededQuntity"));
    });
  }

  getMorePosts() async {
    if (gettingPosts) return;
    setState(() => gettingPosts = true);

    list = await FireStoreServices(uid: "").getMorePosts(lastUID, lastPostTime);

    if (list.length < 10) setState(() => noMorePosts = true);
    else setState(() => noMorePosts = false);

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
          time: DateTime(1),
          Location: "Location",
          NeededQuntity: "NeededQuntity"));
      gettingPosts = false;
    });
  }

  Posts casting(Map<String, dynamic> e) {
    lastUID = e["UID"];
    lastPostTime = e["Time"];
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
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
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

class DataSearch extends SearchDelegate<String> {
  final Medicines = [
    "OMEPRAZOLE",
    "IBUPROFEN",
    "Aspirin",
    "Diclofenac",
    "Minoxidil",
    "Paracetamol",
    "Ranitidine",
    "Citalopram",
  ];

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
        onPressed: () =>  close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: SearchPage(medName: query),
            duration: Duration(milliseconds: 1000)));
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // we should have list from his search history in the database
    final suggestions = Medicines.where(
            (element) => element.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          close(context, null);
          // We should add the search result text to his history in the database
          // may be we don't need this function and go to MedicineResultPage

          query = suggestions[index];

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: SearchPage(medName: query),
                  duration: Duration(milliseconds: 1000)));
        },
        leading: FaIcon(FontAwesomeIcons.pills),
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
