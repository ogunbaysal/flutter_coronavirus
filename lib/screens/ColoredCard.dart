import 'package:flutter/material.dart';

class ColoredCard extends StatelessWidget {
  String title;
  String content;
  Color backroundColor = Colors.grey;
  double width = 130;
  ColoredCard({this.title, this.content, this.backroundColor, this.width = 130});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      width: width,
      child: Card(
        color: backroundColor,
        elevation: 20,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15.0)),
              SizedBox(height: 10,),
              Text(content, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,letterSpacing: 2, fontSize: 20.0))
              ],
            ),
          )
        )
    );
  }
}