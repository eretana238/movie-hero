// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_hero/models/movie.dart';
import 'package:movie_hero/screens/movie_info_screen.dart';
import 'package:movie_hero/services/db_service.dart';

class MovieCarousel extends StatefulWidget {
  final String _title;
  final int _movieCollectionIndex;

  MovieCarousel(this._title, this._movieCollectionIndex);

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  String posterURL;
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
                widget._title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          height: 130.0,
          child: StreamBuilder(
            stream: DBService.collections[widget._movieCollectionIndex].snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading..');
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 6.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document =
                      snapshot.data.documents[index];
                      posterURL = document['posterURL'];
                  Movie movie = new Movie(
                      document['category'],
                      document['title'],
                      document['posterURL'],
                      document['cast'],
                      document['location']);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieInfoScreen(movie: movie, collection: widget._title),
                        ),
                      );
                    },
                    child: Container(
                      child: Image.network(
                        posterURL,
                        width: 85.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
