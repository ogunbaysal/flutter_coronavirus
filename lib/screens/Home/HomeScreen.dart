import 'package:coronavirus/api/ApiService.dart';
import 'package:coronavirus/config/AppState.dart';
import 'package:coronavirus/extensions/date_picker_timeline/date_picker_timeline.dart';
import 'package:coronavirus/models/CountryHistoryByDate.dart';
import 'package:coronavirus/models/CountryStats.dart';
import 'package:coronavirus/models/StatsByCountry.dart';
import 'package:coronavirus/screens/ColoredCard.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color cardBackroundColor = Colors.blue;
  DateTime _selectedDateValue = DateTime.now();
  Future<CountryStats> futureStats;
  Future<CountryHistoryByDate> futureCountryStatsByDate;
  @override
  void initState() { 
    AppState.isLoading = true;
    super.initState();
    futureStats = ApiService.getSavedCountryInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CountryStats>(
          future: futureStats,
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              return content(snapshot.data.stats[0]);
            }
            else if(snapshot.hasError)
            {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator(),);
          }
        ),
      );
  }
  Widget content(StatsByCountry data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text(data.countryName, textAlign: TextAlign.center,),),

        ),
        SizedBox(height: 15,),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: DatePickerTimeline(
            _selectedDateValue,
        
            onDateChange: (date)
            {
              setState(() {
                _selectedDateValue = date;
              });
            },
          ),
        ),
        SizedBox(height: 50,),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            new FutureBuilder<CountryHistoryByDate>(
              future: ApiService.getCountryHistoryByDate(date: _selectedDateValue),
              builder: (context, snapshot)
              {
                if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
                if(snapshot.hasData)
                {
                  var noData = false;
                  var response = snapshot.data.response;
                  Response item;
                  if(response == null || response.length == 0 )
                  {
                      noData = true;
                  }
                  else{
                    item = response.first;
                  }
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ColoredCard(
                          title: "New Cases",
                          content: noData ? "0" : item.cases.newCases.toString(),
                          backroundColor: cardBackroundColor
                        ),
                        new ColoredCard(
                          title: "New Deaths",
                          content: noData ? "0" : item.deaths.newCases.toString(),
                          backroundColor: cardBackroundColor
                        ),
                      ],
                    );
                }
                else if(snapshot.hasError)
                {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator(),);
              },
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
        )
      ],
    );
  }
}