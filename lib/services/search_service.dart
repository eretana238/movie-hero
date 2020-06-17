import 'package:movie_hero/services/db_service.dart';

class SearchService {
  searchByname(String searchField) {
    return DBService.collections[1]
      .where('key', isEqualTo: searchField.substring(0,1).toUpperCase())
      .getDocuments();
  }
}
