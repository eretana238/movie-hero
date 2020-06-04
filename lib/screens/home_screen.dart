import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.apps,
            size: 26.0,
            color: Colors.black,
          ),
          onPressed: () => print('pressed apps'),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 28.0,
              ),
              onPressed: () => print('pressed add'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            MovieCarousel('Recently Checked out', 4),
            MovieCarousel('Recommended', 7),
          ],
        ),
      ),
      bottomNavigationBar: ,
    );
  }
}
