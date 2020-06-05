import 'package:flutter/material.dart';
import 'package:movie_hero/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Hero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF2E43FF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Lato'
      ),
      home: Home(),
    );
  }
}
