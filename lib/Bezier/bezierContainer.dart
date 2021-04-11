import 'dart:math';
import 'package:flutter/material.dart';
import 'customClipper.dart';

class BezierContainer extends StatefulWidget {
  final double divisor;

  BezierContainer({@required this.divisor});

  @override
  _BezierContainerState createState() => _BezierContainerState();
}

class _BezierContainerState extends State<BezierContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / widget.divisor,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color.fromRGBO(183, 0, 143, 1), Color.fromRGBO(203, 0, 254, 1)])),
        ),
      ),
    ));
  }
}
