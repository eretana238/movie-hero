// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movie_hero/components/movie_carousel.dart';

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
    'Family',
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

