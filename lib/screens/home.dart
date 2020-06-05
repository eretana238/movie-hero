import 'package:flutter/material.dart';
import 'package:movie_hero/screens/home_screen.dart';
import 'package:movie_hero/screens/movie_screen.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _selectedIndex = 0;
   
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MovieScreen(),
    Text('Settings'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff101010),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 28.0,
              ),
              onPressed: () => print('pressed add'),
            ),
          ),
        ],
      ),
      body:  _widgetOptions.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff101010),
        unselectedItemColor: Colors.white24,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            title: Text('Movies'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

