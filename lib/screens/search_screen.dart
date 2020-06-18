import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_hero/models/movie.dart';
import 'package:movie_hero/screens/movie_info_screen.dart';
import 'package:movie_hero/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var queryResultSet = [];
  var tempSearchStore = [];

  bool searchByName = true;

  Widget resultCard(context, document) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Card(
        color: Colors.black,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(50),
          onTap: () {
            Movie movie = new Movie(document['category'], document['title'],
                document['posterURL'], document['cast'], document['location']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieInfoScreen(movie: movie),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(
                document['posterURL'],
                height: 50.0,
              ),
              Text(
                document['title'],
              ),
              Text(
                document['year'],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectionButton(content, color) {
    return Container(
      height: 30.0,
      width: 80.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Text(content),
      ),
    );
  }

  initiateSearchByName(value) {
    // resets search
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue = value.toString().toUpperCase();
    // start search
    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByname(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; i++) {
          queryResultSet.add(docs.documents[i].data);
          setState(() {
            tempSearchStore.add(docs.documents[i].data);
          });
        }
      });
    } else {
      setState(() {
        tempSearchStore = [];
      });
      queryResultSet.forEach((element) {
        if (element['title']
            .toString()
            .toUpperCase()
            .startsWith(capitalizedValue)) {
          print(element['title']);
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (value) {
              initiateSearchByName(value);
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if(!searchByName)
                  setState(() {
                    searchByName = !searchByName;
                  });
              },
              child: selectionButton('name', searchByName ? Theme.of(context).primaryColor: Color(0xff202020)),
            ),
            SizedBox(width: 20.0,),
            GestureDetector(
              onTap: () {
                if(searchByName)
                  setState(() {
                    searchByName = !searchByName;
                  });
              },
              child: selectionButton('cast', !searchByName ? Theme.of(context).primaryColor: Color(0xff202020)),
            )
          ],
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: tempSearchStore.map((element) {
              return resultCard(context, element);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
