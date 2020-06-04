import 'package:flutter/material.dart';
import 'package:movie_hero/models/movie.dart';
import 'package:movie_hero/screens/movie_screen.dart';

class MovieCarousel extends StatelessWidget {
  String _title;
  int _movies;
  // List<Movie> movies;

  MovieCarousel(this._title, this._movies);

  Color secondary = Color(0xFFFF2E2E);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onTap: () => print('pressed see all'),
              ),
            ],
          ),
        ),
        Container(
          height: 130.0,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            scrollDirection: Axis.horizontal,
            itemCount: _movies,
            itemBuilder: (context, index) {
              // TODO: create movie here
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieScreen(),
                  ),
                ),
                child: Container(
                  child: Image.asset('assets/images/movie11.jpg'),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 6.0,
            ),
          ),
        ),
      ],
    );
  }
}
