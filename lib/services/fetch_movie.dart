import 'package:http/http.dart' as http;
import 'package:movie_hero/models/keys.dart';
import 'dart:convert' show json;

/*
 * Class keys contains the api keys to make http requests work
*/
class FetchMovie{
  static FetchMovie _instance;

  static String _title;
  static String _year;

  String _posterURL;
  String _castURL;

  dynamic _requestData;
  
  FetchMovie._();

  static FetchMovie getInstance() {
    if(_instance == null)
      _instance = new FetchMovie._();
    return _instance;
  }
  
  set title(String title) {
    _title = title;
    // _parseTitle();
  }

  set year(String year) {
    _year = year;
  }

  Future<dynamic> makeRequest() async {
    final String requestURL = 'https://movie-database-imdb-alternative.p.rapidapi.com/?page=1&y=$_year&r=json&s=$_title';
    var response = await http.get(
      requestURL,
      headers: {
        'Accept': 'application/json',
        'X-RapidAPI-Host': 'movie-database-imdb-alternative.p.rapidapi.com',
        'X-RapidAPI-Key': Keys.rapidAPIKey,
      }
    );
    if(response.statusCode == 200){
      var res = response.body;
      var data = json.decode(res);
      print(data['Search'][0]['Title']);
      return data['Search'];
    }
    else {
      print('Request failed with status: ${response.statusCode}.'); 
      return null;
    }
  }

  Future<String> fetchCast(dynamic data) async{
    
    var response = await http.get(
      'https://www.imdb.com/title/' + data['imdbID'],
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