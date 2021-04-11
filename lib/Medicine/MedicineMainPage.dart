import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/Blood/Request_Blood.dart';
import 'package:medicine/Medicine/Add_Medicine_Post.dart';
import 'package:medicine/Medicine/Request_Medicine_Post.dart';
import 'package:medicine/Models/Profile.dart';
import 'package:medicine/Shared/SharedConstants.dart';
import 'package:page_transition/page_transition.dart';
import 'Medicine_Main_Posts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicineMainPage extends StatefulWidget {
  @override
  _MedicineMainPageState createState() => _MedicineMainPageState();
}

class _MedicineMainPageState extends State<MedicineMainPage> {
  int _page;
  PageController _pageController;

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

  Widget _containers(String image, String category) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedicineMainPosts(category: category)));
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
                Text(category,
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
        const IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null),
        FontAwesomeIcons.pills,
        Icons.home,
        Icons.person,
      ],
      activeIndex: _page,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      backgroundColor: (_page == 0) ? BloodActiveColor : MedicineActiveColor,
      activeColor: Colors.blue,
      inactiveColor: Colors.white,
      onTap: (i) => setState(() {
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
        backgroundColor: (_page == 0) ? BloodActiveColor : MedicineActiveColor,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: RequestMedicinePost(),
                  duration: Duration(milliseconds: 500)));
        },
        child: Icon(Icons.add,color: Colors.white),
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

