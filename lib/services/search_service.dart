// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
class SearchService {
  searchByname(String searchField, CollectionReference collection) {
    return collection
      .where('key', isEqualTo: searchField.substring(0,1).toUpperCase())
      .getDocuments();
  }
  // searchByCast(String searchField, CollectionReference collection) {
  //   return collection
  //     .where('cast')
  //     .getDocuments();
  // } 
}
