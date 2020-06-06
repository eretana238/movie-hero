import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
   @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MovieCarousel('Recently Checked out', 5),
        MovieCarousel('Recently Checked in', 15),
        // TODO: implement pick of the day here
        MovieCarousel('Recommended', 7),
        MovieCarousel('Action & Adventure', 40),
        MovieCarousel('Comedy', 40),
        MovieCarousel('Family', 30),
        MovieCarousel('Drama', 15),
        MovieCarousel('Thrillers', 15),
      ],
    );
  }
}

