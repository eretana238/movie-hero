import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('hello'),
        ),
        // ListView(
        //   children: <Widget>[],
        // ),
      ],
    );
  }
}
