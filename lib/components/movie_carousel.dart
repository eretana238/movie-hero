import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_hero/screens/movie_info_screen.dart';
// import 'package:movie_hero/screens/movie_info_screen.dart';
import 'package:movie_hero/services/db_service.dart';

class MovieCarousel extends StatelessWidget {
  String _title;
  int _movieCollectionIndex;

  MovieCarousel(this._title, this._movieCollectionIndex);

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
            stream: DBService.collections[_movieCollectionIndex].snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading..');
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 6.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document =
                      snapshot.data.documents[index];
                  final dynamic imageURL = document['imageURL'];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        // TODO: add optoin to pass documents with data to movie info screen
                        builder: (_) => MovieInfoScreen(),
                      ),
                    ),
                    child: Container(
                      child: Image.network(
                        imageURL,
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
