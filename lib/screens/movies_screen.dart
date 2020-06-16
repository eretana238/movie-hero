import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';
import 'package:movie_hero/services/db_service.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<String> categories = [
    'Checked out',
    'Action & Adventure',
    'Comedy',
    'Crime',
    'Drama',
    'Epics',
    'Horror',
    'Musicals',
    'Sci-fi',
    'Thrillers',
    'War',
    'Westerns'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return MovieCarousel(categories[index], index);
      },
    );
  }
}

