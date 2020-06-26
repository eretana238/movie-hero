// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_hero/models/movie.dart';
import 'package:movie_hero/services/db_service.dart';
import 'package:movie_hero/services/http_service.dart';

class AddMovieScreen extends StatefulWidget {
  final String location;
  AddMovieScreen({Key key, this.location}) : super(key: key);
  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final HttpService _httpService = HttpService.getInstance();
  bool isSubmitting = false;
  bool isMovieFound = true;

  final _titleController = TextEditingController();
  final _yearController = TextEditingController();

  String dropdownValue = 'action-adventure';
  int dropdownIndex = 0;

  List<String> genres = [
    'action-adventure',
    'comedy',
    'crime',
    'drama',
    'epics',
    'family',
    'horror',
    'musicals',
    'sci-fi',
    'thrillers',
    'war',
    'westerns'
  ];

  Widget _buildErrorMessage() {
    return isMovieFound ? null : Text(
      'Error: Movie not found please try again.',
      style: TextStyle(
        color: Colors.red
      ),
    );
  }
  // fetches information from movie database api, and adds it in the movie hero database
  Future<void> _submit() async {
    isSubmitting = true;
    dynamic movieData = await _httpService.requestRapidAPI(
        '${_titleController.text}', '${_yearController.text}');
    if (movieData['Search'] != null) {
      List<String> castData =
          await _httpService.requestImdb(movieData['Search'][0]['imdbID']);
      CollectionReference collection =
          DBService.collections[genres.indexOf(dropdownValue) + 1];
      Movie movie = new Movie.fromJSON(movieData);
      movie.setCast = castData;
      movie.setCategory = dropdownValue;
      movie.setLocation = widget.location;
      DBService.addDocument(collection, movie.toJson());
      setState(() {
        isSubmitting = false;
        isMovieFound = true;
      });
    } 
    else {
      setState(() {
        isSubmitting = false;
        isMovieFound = false;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        title: Text('Add Movie'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (!isSubmitting) Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            height: 400.0,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Add title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  controller: _titleController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.access_time,
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Add year (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  controller: _yearController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Center(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        // color: Theme.of(context).primaryColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items:
                          genres.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await _submit();
                          setState(() {
                            _titleController.clear();
                            _yearController.clear();
                            _formKey.currentState.reset();
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('ADD'),
                          Icon(
                            Icons.add,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: _buildErrorMessage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
