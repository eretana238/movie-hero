// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

class Movie {
  final String _category;
  final String _title;
  final String _posterURL;
  final dynamic _cast;
  final String _location;

  Movie(this._category, this._title, this._posterURL, this._cast, this._location);

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
}