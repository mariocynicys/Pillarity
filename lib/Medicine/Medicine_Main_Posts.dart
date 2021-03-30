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
      PostText: "Hi, I am Dr. Ziyad Hassan and here is my new medical tip",
      Medincie: "Antinal",
      Time: "24 min ago",
    ),
    Posts(
      Auther: "omar yacine",
      PostText: "I dont know what to say",
      Medincie: "Antinal",
      Time: "26 min ago",
    ),
    Posts(
      Auther: "AbdelHamid",
      PostText: "Hi",
      Medincie: "Antinal",
      Time: "30 min ago",
    ),
    Posts(
      Auther: "Ghareeb",
      PostText: "A5oooooya",
      Medincie: "Antinal",
      Time: "1 hour ago",
    ),
    Posts(
      Auther: "Ghareeb",
      PostText: "A5oooooya",
      Medincie: "Antinal",
      Time: "1 hour ago",
    ),
    Posts(
      Auther: "Ghareeb",
      PostText: "A5oooooya",
      Medincie: "Antinal",
      Time: "2 hours ago",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
