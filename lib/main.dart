import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:coronavirus/config/AppState.dart';
import 'package:coronavirus/config/Cons.dart';
import 'package:coronavirus/config/Prefs.dart';
import 'package:coronavirus/helpers/PreferencesHelper.dart';
import 'package:coronavirus/screens/Home/HomeScreen.dart';
import 'package:coronavirus/screens/Search/SearchScreen.dart';
import 'package:coronavirus/screens/Settings/Settings.dart';
import 'package:coronavirus/screens/World/WorldScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Virus',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        cardColor: Colors.blue,
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Corona Virus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;
  Color inActiveBottomItem = Colors.white;
  Color activeBottomItem = Colors.white;
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(widget.title, style: TextStyle(color: Colors.blue),),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        backgroundColor: Theme.of(context).backgroundColor,
        showElevation: true,
        onItemSelected: (index) => setState(() {
                    _currentIndex = index;
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
            inactiveColor: inActiveBottomItem,
            activeColor: activeBottomItem
          ),
          BottomNavyBarItem(
            title: Text('Search'),
            icon: Icon(Icons.search),
            inactiveColor: inActiveBottomItem,
            activeColor: activeBottomItem
          ),
          BottomNavyBarItem(
            title: Text('Worlds'),
            icon: Icon(Icons.flag),
            inactiveColor: inActiveBottomItem,
            activeColor: activeBottomItem
          ),
          BottomNavyBarItem(
            title: Text('Settings'),
            icon: Icon(Icons.settings),
            inactiveColor: inActiveBottomItem,
            activeColor: activeBottomItem
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              WorldScreen(),
              SettingsScreen()
            ],
          ),
        ),
      )
    
     );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
