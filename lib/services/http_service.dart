// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:movie_hero/models/keys.dart';
import 'dart:convert' show json;

// Class [Keys] contains the api keys to make http requests
class HttpService {
  static HttpService _instance;

  HttpService._();

  static HttpService getInstance() {
    if (_instance == null) _instance = new HttpService._();
    return _instance;
  }

  // Makes request to retrieve movie info from rapidAPI
  // Requests Title, Year, imdbID, and Poster
  Future<dynamic> requestRapidAPI(String title, String year) async {
    final String requestURL = year != null
        ? 'https://movie-database-imdb-alternative.p.rapidapi.com/?page=1&y=$year&r=json&s=$title'
        : 'https://movie-database-imdb-alternative.p.rapidapi.com/?page=1&r=json&s=$title';
    var response = await http.get(requestURL, headers: {
      'Accept': 'application/json',
      'X-RapidAPI-Host': 'movie-database-imdb-alternative.p.rapidapi.com',
      'X-RapidAPI-Key': Keys.rapidAPIKey,
    });
    if (response.statusCode == 200) {
      String res = response.body;
      return json.decode(res);
    }
    print('Request failed with status: ${response.statusCode}.');
    return null;
  }

  // Makes request to retrieve movie info from IMDB
  // Requests Cast
  Future<List<String>> requestImdb(String imdbID) async {
    List<String> cast = new List(8);
    var response = await http.get(
      'https://www.imdb.com/title/' + imdbID,
    );
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var tableRows = document.querySelectorAll('.cast_list tbody tr');
      for (int i = 1; i < 9; i++) {
        cast[i - 1] = tableRows[i].children[1].querySelector('a').text.trim();
      }
      return cast;
    }
    print('Request failed with status: ${response.statusCode}.');
    return null;
  }
}
