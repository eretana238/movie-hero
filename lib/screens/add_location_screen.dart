// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_hero/screens/add_movie_screen.dart';
import 'package:movie_hero/services/db_service.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String location;
  final _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        title: Text('Movie location'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Container(
                height: 400.0,
                child: StreamBuilder(
                  stream: DBService.locations.orderBy('location',descending: false).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading..');
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 10.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot document =
                            snapshot.data.documents[index];
                        location = document['location'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddMovieScreen(
                                  location: location,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 40.0,
                            color: Colors.blue,
                            child: Center(child: Text('$location')),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 19.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Add location',
                        ),
                        controller: _locationController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter location';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        DBService.addLocation(_locationController.text);
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
