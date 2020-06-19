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
