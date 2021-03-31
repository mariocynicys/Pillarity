import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Blood/Request_Blood.dart';
import 'package:medicine/Medicine/Add_Medicine_Post.dart';
import 'package:medicine/Medicine/Request_Medicine_Post.dart';
import 'package:medicine/Profile.dart';
import 'package:page_transition/page_transition.dart';
import 'Medicine_Main_Posts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Post.dart';

class MedicineMainPage extends StatefulWidget {
  @override
  _MedicineMainPageState createState() => _MedicineMainPageState();
}

class _MedicineMainPageState extends State<MedicineMainPage> {
  int _page;
  PageController _pageController;
  Color activeColor = Colors.blue;
  Color inActiveColor = Colors.yellow;

  @override
  void initState() {
    super.initState();
    _page = 2;
    _pageController = new PageController(initialPage: _page);
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(child: Text('Drawer Header')),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Add Medicine'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Add Blood'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Medicine"),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            })
      ],
    );
  }

  Widget _containers(String image, String Catagory) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedicineMainPosts(Catagory: Catagory)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Material(
            color: Colors.white,
            elevation: 14,
            borderRadius: BorderRadius.circular(12),
            shadowColor: Color(0x802196F3),
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        image: NetworkImage(image)),
                  ),
                ),
                Text(Catagory,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _containers(
                "https://e7.pngegg.com/pngimages/664/537/png-clipart-cough-elderly-sick-cough.png",
                "Cough"),
            _containers(
                "https://banner2.cleanpng.com/20180705/els/kisspng-headache-migraine-dentistry-neck-pain-5b3e6c021da598.2498092615308175381214.jpg",
                "Headache"),
            _containers(
                "https://toppng.com/uploads/preview/homem-tendo-infarto-png-heart-attack-man-meme-11562899388dbsmj143px.png",
                "Heart attack"),
            _containers(
                "https://img.lovepik.com/element/40084/7845.png_860.png",
                "Elbow"),
            _containers(
                "https://img.lovepik.com/element/40169/6765.png_860.png",
                "Knee"),
            _containers(
                "https://e7.pngegg.com/pngimages/958/894/png-clipart-back-pain-pain-management-chiropractic-surgery-injury-others-arm-pain.png",
                "Backbone"),
            _containers(
                "https://www.backtohealthphysio.com.au/wp-content/uploads/Neck-Pain.png",
                "Neck"),
          ],
        ),
      ),
    );
  }

  Widget _navBar2() {
    return BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.green,
        iconSize: 25,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.yellow,
        unselectedLabelStyle: TextStyle(color: Colors.yellow),
        selectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12,
        onTap: (int i) {
          setState(() {
            _pageController.animateToPage(i,
                duration: Duration(milliseconds: 100), curve: Curves.easeIn);
            _page = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "sa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet_giftcard), label: "sa"),
          BottomNavigationBarItem(icon: Icon(Icons.face_sharp), label: "sa"),
          BottomNavigationBarItem(icon: Icon(Icons.view_day), label: "sa")
        ]);
  }

  Widget _navBar() {
    return CurvedNavigationBar(
      backgroundColor: Color.fromRGBO(183, 0, 143, 1),
      index: _page,
      color: Color.fromRGBO(203, 0, 254, 1),
      animationDuration: Duration(milliseconds: 100),
      buttonBackgroundColor: Colors.white,
      height: 60,
      items: <Widget>[
        Icon(FontAwesomeIcons.waveSquare, size: 30),
        Icon(FontAwesomeIcons.pills, size: 30),
        Icon(FontAwesomeIcons.podcast, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.person, size: 30),
      ],
      onTap: (i) {
        setState(() {
          _pageController.animateToPage(i,
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
          _page = i;
        });
      },
    );
  }

  Widget _navBar3() {
    return AnimatedBottomNavigationBar(
      icons: [
        FontAwesomeIcons.waveSquare,
        FontAwesomeIcons.pills,
        FontAwesomeIcons.podcast,
        //  Icons.add,
        Icons.person,
      ],
      activeIndex: _page,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      backgroundColor: Colors.grey,
      activeColor: Colors.blue,
      inactiveColor: inActiveColor,
      onTap: (i) => setState(() {
          activeColor = Colors.blue;
          _pageController.animateToPage(i,
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
          _page = i;
      }),
      //other params
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: RequestMedicinePost(),
                  duration: Duration(milliseconds: 500)));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: _drawer(),
      bottomNavigationBar: _navBar3(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (i) {
          setState(() {
            _page = i;
          });
        },
        children: [
          RequestBlood(),
          AddMedicinePost(),
          MedicineMainPosts(),
          Profile(),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = ["Cairo", "Alex", "Matrough", "masr", "ziyad", "Omar"];

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
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // we should have list from his search history in the database
    final seggestionlist = cities
        .where(
            (element) => element.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: seggestionlist.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // We should add the search result text to his history in the database
          showResults(
              context); // may be we don't need this function and go to MedicineResultPage immed
        },
        leading: FaIcon(FontAwesomeIcons.pills),
        title: RichText(
          text: TextSpan(
              text: seggestionlist[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: seggestionlist[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
    );
  }
}