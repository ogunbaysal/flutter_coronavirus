import 'package:coronavirus/api/ApiService.dart';
import 'package:coronavirus/models/CasesByCountry.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = "";
  TextEditingController _searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = new TextEditingController();
    _searchText = "";
    _searchController.value = TextEditingValue(text: _searchText);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              onChanged: (value)
              {
                setState(() {
                  _searchText = value;
                });
              },
              textAlign: TextAlign.start,
              style: TextStyle(color: Theme.of(context).primaryColor),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                hintText: "Search for Country",
                hintStyle: TextStyle(color: Theme.of(context).primaryColor)
              ),
            ),
          ),
          Container(
            child: FutureBuilder<List<CountriesStat>>(
              future: ApiService.getCasesByCountry(search: _searchText == "" ? null : _searchText),
              builder: (context, snapshot)
              {
                if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
                if(snapshot.hasData)
                {
                  return content(snapshot.data);
                }
                else if(snapshot.hasError)
                {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator(),);
              },
            )
          )
        ],
      ),
    );
  }
  Widget content(List<CountriesStat> data)
  {
    return Expanded(
        child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index)
        {
          var item = data[index];
          return getCard(
            country: item.countryName,
            totalCases: item.cases,
            totalDeaths: item.deaths
          ); 
        },
      ),
    );
  }
  Widget getCard({String country, String totalDeaths, String totalCases})
  {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(country, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),),
          subtitle: Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total Case : " + totalCases, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),),
                Text("Total Deaths : " + totalDeaths, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),)
              ],
            ),
          ),
          //trailing: Icon(Icons.chevron_right, size: 40, color: Theme.of(context).primaryColor,),
        ),
      ),
    );
  }
 
}