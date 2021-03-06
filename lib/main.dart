// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movie_hero/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Hero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        primaryColor: Color(0xFF2E43FF),
        brightness: Brightness.dark,
        accentColor: Color(0xFF2E43FF),
        scaffoldBackgroundColor: Color(0xff101010),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Lato',
        
      ),
      home: Home(),
    );
  }
}
