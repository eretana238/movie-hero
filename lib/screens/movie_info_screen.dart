// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movie_hero/models/movie.dart';
import 'package:movie_hero/services/db_service.dart';

class MovieInfoScreen extends StatefulWidget {
  final Movie movie;
  final String collection;

  MovieInfoScreen({Key key, this.movie, this.collection}) : super(key: key);

  @override
  _MovieInfoScreenState createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  String collection;
  bool isCheckedOut;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Movie Location'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(widget.movie.location),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    collection = widget.collection;
    collection == 'Checked out' ? isCheckedOut = true : isCheckedOut = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 550.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.movie.posterURL,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                        0.0,
                        0.3,
                        1.0
                      ],
                          colors: [
                        const Color(0xFF101010),
                        const Color(0x00101010),
                        const Color(0xFF101010),
                      ])),
                ),
              ),
              /*
              * Raised button
              */
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 19.0),
                    child: Center(
                      child: RaisedButton(
                        color: isCheckedOut
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                        onPressed: () {
                          if (isCheckedOut)
                            DBService.checkinDocument(widget.movie.title);
                          else
                            DBService.checkoutDocument(
                                widget.movie.title, widget.movie.category);

                          setState(() {
                            isCheckedOut = !isCheckedOut;
                          });
                          _showMyDialog();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            isCheckedOut ? Text('CHECKIN') : Text('CHECKOUT'),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              isCheckedOut
                                  ? Icons.subdirectory_arrow_left
                                  : Icons.subdirectory_arrow_right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 19.0),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          DBService.removeDocument(DBService.getCollectionFromString(widget.movie.category), widget.movie.title);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Delete'),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.delete,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Cast: '),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.movie.cast[0]),
                      Text(widget.movie.cast[1]),
                      Text(widget.movie.cast[2]),
                      Text(widget.movie.cast[3]),
                      Text(widget.movie.cast[4]),
                      Text(widget.movie.cast[5]),
                      Text(widget.movie.cast[6]),
                      Text(widget.movie.cast[7])
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
