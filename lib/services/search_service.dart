// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
class SearchService {
  // gets all of the movies with the same starting key
  searchByname(String searchField, CollectionReference collection) {
    return collection
      .where('key', isEqualTo: searchField.substring(0,1).toUpperCase())
      .getDocuments();
  }
  // gets all of the movies that have the same cast member
  searchByCast(String searchField, CollectionReference collection) {
    List<String> names = searchField.split(' ');
    searchField = '';
    names.forEach((element) {
      searchField += element.substring(0,1).toUpperCase() + element.substring(1) + ' ';
    });
    return collection
      .where('cast', arrayContains: searchField.substring(0,searchField.length-1))
      .getDocuments();
  } 
}
