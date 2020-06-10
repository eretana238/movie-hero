import 'package:flutter/material.dart';
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
          height: 130.0,
          child: StreamBuilder(
            stream: DBService.movieCollections()[_movieCollectionIndex].snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading..');
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: snapshot.data.documents.length,
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

// ListView.separated(
//             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//             scrollDirection: Axis.horizontal,
//             itemCount: 6,
//             itemBuilder: (context, index) {
//               // TODO: create movie here
//               return GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => MovieInfoScreen(),
//                   ),
//                 ),
//                 child: Container(
//                   child: Image.asset('assets/images/movie11.jpg'),
//                 ),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) => SizedBox(
//               width: 6.0,
//             ),
//           ),
