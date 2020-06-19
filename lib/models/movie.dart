// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

class Movie {
  String _imdbID;
  String _title;
  String _year;
  String _posterURL;
  String _category;
  String _location;
  dynamic _cast;

  Movie(this._category, this._title, this._posterURL, this._cast, this._location);

  // Stores movie from encoded json data 
  Movie.fromJSON(data) {
    this._title = data['Search'][0]['Title'];
    this._year = data['Search'][0]['Year'];
    this._imdbID = data['Search'][0]['imdbID'];
    this._posterURL = data['Search'][0]['Poster'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': _title,
      'year': _year,
      'cast': _cast,
      'category': _category,
      'posterURL': _posterURL,
      'location': _location,
      'key': _title.substring(0,1)
    };
    return json;
  }

  set setCategory(String category) {
    _category = category;
  }
  set setLocation(String location) {
    _location = location;
  }
  set setCast(dynamic cast) {
    _cast = cast;
  }

  String get category {
    return _category;
  }
  String get title {
    return _title;
  }
  String get posterURL {
    return _posterURL;
  }
  dynamic get cast {
    return _cast;
  }
  String get location {
    return _location;
  }
  String get imdbID {
    return _imdbID;
  }
  String get year {
    return _year;
  }
}