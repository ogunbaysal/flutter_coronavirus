import 'package:coronavirus/api/ApiService.dart';
import 'package:coronavirus/config/Prefs.dart';
import 'package:coronavirus/models/AffectedCountries.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedCountry;
  void getSelectedCountry() async{
    selectedCountry = await Prefs.Country;
  }
  @override
  void initState() { 
    getSelectedCountry();
    super.initState();
  }
  Future saveSettings() async
  {
    await Prefs.setCountry(selectedCountry);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<AffectedCountries>(
        future: ApiService.getCountries(),
        builder: (context, snapshot){
          if(snapshot.hasData)
          {
            return content(snapshot.data.countries);
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
  Widget content(List<String> data)
  {
      return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(Icons.settings),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const ListTile(
                      title: Text('Country', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                        onChanged: (String string) => setState(() => selectedCountry = string),
                        items: data != null
                            ? data.map((String item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList()
                            : [],
                        value: selectedCountry
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 15),
                child: Card(
                  child: FlatButton(
                    child: Text("Save"),
                    onPressed: (){
                      saveSettings();
                      final snack =  SnackBar(
                          content: Text("Succesfully saved"),
                          duration: Duration(seconds: 2),
                      );
                      Scaffold.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}