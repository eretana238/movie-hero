import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<String> genres = [
    'Action & Adventure',
    'Comedy',
    'Crime',
    'Drama',
    'Epics',
    'Horror',
    'Sci-fi',
    'Thrillers',
    'War',
    'Westerns'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MovieCarousel('Action & Adventure', 0),
      ],
    );
  }
}

