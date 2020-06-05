import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MovieCarousel('Recently Checkeed out', 5),
        MovieCarousel('Recommended', 7),
      ],
    );
  }
}

