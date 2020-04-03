import 'package:coronavirus/api/ApiService.dart';
import 'package:coronavirus/models/WorldStats.dart';
import 'package:coronavirus/screens/ColoredCard.dart';
import 'package:flutter/material.dart';

class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  Color cardBackroundColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<WorldStats>(
        future: ApiService.getWorldStats(),
        builder: (context, snapshot)
        {
          if(snapshot.hasData)
          {
              return Center(child: content(snapshot.data),);
          }
          else if(snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
  Widget content(WorldStats data)
  {
      return Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        runSpacing: 20,
        children: [
          new ColoredCard(
            title: "New Cases",
            content: data.newCases,
            backroundColor: cardBackroundColor,
            width: 150,
          ),
          new ColoredCard(
            title: "New Deaths",
            content: data.newDeaths,
            backroundColor: cardBackroundColor,
            width: 150,
          ),
          new ColoredCard(
            title: "Total Cases",
            content: data.totalCases,
            backroundColor: cardBackroundColor
          ),
          new ColoredCard(
            title: "Total Recovered",
            content: data.totalRecovered,
            backroundColor: cardBackroundColor
          ),
          new ColoredCard(
            title: "Total Deaths",
            content: data.totalDeaths,
            backroundColor: cardBackroundColor
          ),
        ],
      );
  }
}