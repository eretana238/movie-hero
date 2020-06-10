import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static final CollectionReference _movies = Firestore.instance.collection('movies');
  static final CollectionReference _actionAdventure = _movies.document().collection('action-adventure');
  static final CollectionReference _comedy = _movies.document().collection('comedy');
  static final CollectionReference _crime = _movies.document().collection('crime');
  static final CollectionReference _drama = _movies.document().collection('drama');
  static final CollectionReference _epics = _movies.document().collection('epics');
  static final CollectionReference _horror = _movies.document().collection('horror');
  static final CollectionReference _musicals = _movies.document().collection('musicals');
  static final CollectionReference _sciFi = _movies.document().collection('sci-fi');    
  static final CollectionReference _thrillers = _movies.document().collection('thrillers');
  static final CollectionReference _war = _movies.document().collection('war');
  static final CollectionReference _westerns = _movies.document().collection('westerns');

  static final List<CollectionReference> _collections = [_actionAdventure, _comedy, _crime, _drama, _epics, _horror, _musicals, _sciFi, _thrillers, _war, _westerns];

  static List<CollectionReference> movieCollections()  {
    return _collections;
  } 
  static CollectionReference movies() {
    return _movies;
  }
}