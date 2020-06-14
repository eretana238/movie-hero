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

  static bool removeDocument(CollectionReference collection, String title) {
    collection.document(title).delete()
      .then((_) => {
        print('Succefully written')
      })
      .catchError((onError) => {
        print('There was an error: $onError')
      });
  }

  static bool checkoutDocument(String title, String category) {
    // get document info
    DocumentReference doc = getCollection(category).document(title);
    doc.get().then((document) => print(document['title']));
    
  }

  static CollectionReference getCollection(String collection) {
    switch (collection) {
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