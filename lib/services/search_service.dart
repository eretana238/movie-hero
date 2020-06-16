import 'package:movie_hero/services/db_service.dart';

class SearchService {
  searchByname(String searchField) {
    // var collections;
    // for (int i = 0; i < DBService.collections.length; i++) {
    //     DBService.collections[i]
    //       .where('key',
    //           isEqualTo: searchField.substring(0, 1).toUpperCase())
    //       .getDocuments()
    //       .then((snapshot) => collections.add(snapshot));
    // }
    // return collections;
    return DBService.collections[1]
      .where('key', isEqualTo: searchField.substring(0,1).toUpperCase())
      .getDocuments();
  }
}
