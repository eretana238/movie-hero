import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static final CollectionReference _actionAdventure = Firestore.instance.collection('action-adventure');
  static final CollectionReference _comedy = Firestore.instance.collection('comedy');
  static final CollectionReference _crime = Firestore.instance.collection('crime');
  static final CollectionReference _drama = Firestore.instance.collection('drama');
  static final CollectionReference _epics = Firestore.instance.collection('epics');
  static final CollectionReference _horror = Firestore.instance.collection('horror');
  static final CollectionReference _musicals = Firestore.instance.collection('musicals');
  static final CollectionReference _sciFi = Firestore.instance.collection('sci-fi');    
  static final CollectionReference _thrillers = Firestore.instance.collection('thrillers');
  static final CollectionReference _war = Firestore.instance.collection('war');
  static final CollectionReference _westerns = Firestore.instance.collection('westerns');

  static final List<CollectionReference> collections = [_actionAdventure, _comedy, _crime, _drama, _epics, _horror, _musicals, _sciFi, _thrillers, _war, _westerns];

  static void addDocument(CollectionReference collection, String title, String year, List<String> cast, String category, String posterURL, String location) {
    var data = {
      'title': title,
      'year': year,
      'cast': cast,
      'category': category,
      'posterURL': posterURL,
      'location': location,
    };
    
    collection.document(title).setData(data)
      .then((_) => {
        print('Succefully written')
      })
      .catchError((onError) => {
        print('There was an error: $onError')
      });
  }

  // static void removeDocument
}