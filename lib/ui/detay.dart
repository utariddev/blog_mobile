import 'package:flutter/material.dart';

class Detay extends StatefulWidget {
//  var imgPath;
//
//  Detay({this.imgPath});

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
           // tag: widget.imgPath,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: AssetImage(), fit: BoxFit.cover),
//              ),
            ),
          ),
        ],
      ),
    );
  }
}
