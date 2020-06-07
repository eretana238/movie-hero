import 'package:http/http.dart' as http;
import 'package:movie_hero/models/keys.dart';


class FetchMovie{
  /*
  * class Keys contains api secret keys to make http requests
  * cx = searchEngineId
  * key = customSearchKey
  */
  static Keys keys = Keys();

  static FetchMovie _instance;

  static String _title;
  static String _cx = keys.searchEngineId;
  static String _key = keys.customSearchKey;

  final String _imagesURL = 'https://customsearch.googleapis.com/customsearch/v1?cx=$_cx&imgSize=MEDIUM&q=$_title&searchType=image&key=$_key';
  final String _castURL = 'https://customsearch.googleapis.com/customsearch/v1?cx=$_cx&q=$_title&key=$_key';
  
  FetchMovie._();

  static FetchMovie getInstance() {
    if(_instance == null)
      _instance = new FetchMovie._();
    return _instance;
  }
  /*
  * Makes regular title in the google query string format: (Hello+world+2)
  */
  void _parseTitle() {
    var splitTitle = _title.split(' ');
    _title = '';
    splitTitle.forEach((element) {
      _title += '$element\%20';
    });
    _title += 'poster';
  }

  set title(String title) {
    _title = title;
    _parseTitle();
  }

  Future<String> getImage() async{
    var response = await http.get(
      _imagesURL,
      headers: {'Accept': 'application/json'}
    );
    if(response.statusCode == 200){
      print(response.body);
      return '';
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<String> getCast() async{
    var response = await http.get(
      _castURL,
      headers: {'Accept': 'application/json'}
    );
    if(response.statusCode == 200){
      print(response.body);
      return '';
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}