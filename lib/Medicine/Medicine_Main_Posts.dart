import 'package:flutter/material.dart';

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

  List<Posts> _newposts = [
    Posts(
      Auther: "Ziyad Hassan",
      PostText: "I need Minoxidil as soon as possible",
      Medincie: "Minoxidil",
      Time: "24 min ago",
    ),
    Posts(
      Auther: "omar yacine",
      PostText: "Could any one help me",
      Medincie: "Antinal",
      Time: "26 min ago",
    ),
    Posts(
      Auther: "AbdelHamid",
      PostText: "I have 8 Tablets of this medicine if anyone need it",
      Medincie: "Paracetamol",
      Time: "30 min ago",
    ),
    Posts(
      Auther: "Hossam",
      PostText: "Urgent please",
      Medincie: "Ranitidine",
      Time: "1 hour ago",
    ),
    Posts(
      Auther: "Ghareeb",
      PostText: "I have excess of this medicine if anyone need it just call me",
      Medincie: "Citalopram",
      Time: "1 hour ago",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        backgroundColor: Color.fromRGBO(118, 0, 210, 1),
      ),
      body: Column(
        children: [
          // Container(height: 10,color: Colors.grey,),
          Expanded(
            child: ListView.builder(
                itemCount: _newposts.length,
                itemBuilder: (context, index) => _newposts[index]),
          ),
        ],
      ),
    );
  }
}
