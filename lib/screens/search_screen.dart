import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (value) {
              // initiateSearch(value);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
              ),
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Search by name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
