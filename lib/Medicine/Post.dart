import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';


class Posts extends StatefulWidget {
  String Auther;
  String PostText;
  String Time;
  String Medincie;

  Posts({this.Medincie, this.Auther, this.PostText, this.Time});


  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      elevation: 14,
      // borderRadius: BorderRadius.circular(12),
      shadowColor: Color(0x802196F3),
      child: Card(
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            ListTile(
              title: Text("${widget.Auther}"),
              subtitle: Text("${widget.Medincie}"),
              trailing: Text("${widget.Time}"),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/Profile.png'),
                radius: 20.0,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${widget.PostText}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            FlatButton(
              onPressed: () async { launch(('tel://01202115813'));},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Contact",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 25, color: Color.fromRGBO(203, 0, 254, 1)),
                ),
              ),
            ),
            Container(height: 10,color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
