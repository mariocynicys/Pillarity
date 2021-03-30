import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'Bezier/bezierContainer.dart';
import 'BloodMainPage.dart';
import 'Medicine/MedicineMainPage.dart';

class ChoosePage extends StatefulWidget {
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  double divisor = 3.5;
  double title1 = 0;
  double title2 = 0;
  double medicineFade = 0;
  double bloodFade = 0;

  double _initialTop = 700;
  double _initialRight = -700;

  @override
  void initState() {
    super.initState();
    title1 = 0;
    title2 = 0;
    medicineFade = 0;
    bloodFade = 0;

    fin();
  }

  void fin() async {
    // _initialTop = -MediaQuery.of(context).size.height * .15;
    // _initialRight = -MediaQuery.of(context).size.width * .4;
    await Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        divisor = -3.5;
        _initialTop = MediaQuery.of(context).size.height * 0.75;
        _initialRight = -MediaQuery.of(context).size.width * 0.4;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        title1 = 1;
      });
    });
    await Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        title2 = 1;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        medicineFade = 1;
      });
    });
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        bloodFade = 1;
      });
    });
  }

  Widget _medicineButton() {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineMainPage())),
      child: Column(
        children: [
          Image(
            height:  MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.25,
            image: AssetImage('assets/medicine_intro.png'),
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          Text(
            "Medicine",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _bloodButton() {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BloodMainPage())),
      child: Column(
        children: [
          Image(
            height:  MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width,
            image: AssetImage('assets/Blood_Intro.png'),
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          Text(
            "Blood",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      children: [
        AnimatedOpacity(
            opacity: title1,
            duration: Duration(seconds: 1),
            child: Text("Medicine",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))),
        AnimatedOpacity(
            opacity: title2,
            duration: Duration(seconds: 1),
            child: Text("Welcome to Google",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned(
              top: height * 0.07,
              right: width * 0.195,
              child: _title(),
            ),
            Positioned(
              top: height * 0.3,
              left: width * 0.38,
              child: AnimatedOpacity(
                opacity: medicineFade,
                duration: Duration(seconds: 1),
                child: _medicineButton(),
              ),
            ),
            Positioned(
              top: height * 0.6,
              left: width * 0.04,
              child: AnimatedOpacity(
                  opacity: bloodFade,
                  duration: Duration(seconds: 1),
                  child: _bloodButton()),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 5),
              top: _initialTop,
              right: _initialRight,
              child: BezierContainer(divisor: divisor),
            ),
          ],
        ),
      ),
    );
  }
}
