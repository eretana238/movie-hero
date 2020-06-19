// Copyright 2020, the Movie Hero authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static final CollectionReference _checkedOut =
      Firestore.instance.collection('checked-out');
  static final CollectionReference _actionAdventure =
      Firestore.instance.collection('action-adventure');
  static final CollectionReference _comedy =
      Firestore.instance.collection('comedy');
  static final CollectionReference _crime =
      Firestore.instance.collection('crime');
  static final CollectionReference _drama =
      Firestore.instance.collection('drama');
  static final CollectionReference _epics =
      Firestore.instance.collection('epics');
  static final CollectionReference _horror =
      Firestore.instance.collection('horror');
  static final CollectionReference _musicals =
      Firestore.instance.collection('musicals');
  static final CollectionReference _sciFi =
      Firestore.instance.collection('sci-fi');
  static final CollectionReference _thrillers =
      Firestore.instance.collection('thrillers');
  static final CollectionReference _war = Firestore.instance.collection('war');
  static final CollectionReference _westerns =
      Firestore.instance.collection('westerns');

  static final List<CollectionReference> collections = [
    _checkedOut,
    _actionAdventure,
    _comedy,
    _crime,
    _drama,
    _epics,
    _horror,
    _musicals,
    _sciFi,
    _thrillers,
    _war,
    _westerns
  ];

  static bool addDocument(CollectionReference collection, Map<String, dynamic> data) {
    collection.document(data['title']).setData(data).then((_) {
      print('Succefully written');
    }).catchError((onError) {
      print('There was an error: $onError');
      return false;
    });
    return true;
  }

  static removeDocument(CollectionReference collection, String title) {
    collection.document(title).delete().then((_) {
      print('Succefully written');
    }).catchError((onError) {
      print('There was an error: $onError');
      return false;
    });
    return true;
  }

  static Future<bool> checkoutDocument(String title, String category) async {
    CollectionReference collection = getCollectionFromString(category);
    DocumentReference doc = collection.document(title);
    bool addedDocument;
    bool removedDocument;

    await doc.get().then((document) {
      addedDocument = addDocument(DBService._checkedOut, document.data);
    });
    removedDocument = removeDocument(collection, title);
    return addedDocument && removedDocument;
  }

  static Future<bool> checkinDocument(String title) async {
    DocumentReference doc = _checkedOut.document(title);
    bool addedDocument;
    bool removedDocument;
    await doc.get().then((document) {
      addedDocument = addDocument(getCollectionFromString(document['category']), document.data);
    });
    removedDocument = removeDocument(_checkedOut, title);
    return addedDocument && removedDocument;
  }

  static CollectionReference getCollectionFromString(String collection) {
    switch (collection) {
      case 'checked-out':
        return _checkedOut;
      case 'action-adventure':
        return _actionAdventure;
      case 'comedy':
        return _comedy;
      case 'drama':
        return _drama;
      case 'epics':
        return _epics;
      case 'horror':
        return _horror;
      case 'musicals':
        return _musicals;
      case 'sci-fi':
        return _sciFi;
      case 'thrillers':
        return _thrillers;
      case 'war':
        return _war;
      case 'westerns':
        return _westerns;
      default:
        return null;
    }
  }
}
