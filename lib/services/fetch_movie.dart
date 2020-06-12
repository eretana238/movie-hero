import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:movie_hero/models/keys.dart';
import 'dart:convert' show json;
/*
 * Class keys contains the api keys to make http requests work
*/
class FetchMovie{
  static FetchMovie _instance;

  String _posterURL;
  String _castURL = 'https://www.imdb.com/title/';
  String _imdbID;
  
  List<String> _cast = new List(8);
  FetchMovie._();

  static FetchMovie getInstance() {
    if(_instance == null)
      _instance = new FetchMovie._();
    return _instance;
  }

  Future<bool> makeRequest(String title, String year) async {
    final String requestURL = 'https://movie-database-imdb-alternative.p.rapidapi.com/?page=1&y=$year&r=json&s=$title';
    var response = await http.get(
      requestURL,
      headers: {
        'Accept': 'application/json',
        'X-RapidAPI-Host': 'movie-database-imdb-alternative.p.rapidapi.com',
        'X-RapidAPI-Key': Keys.rapidAPIKey,
      }
    );
    if(response.statusCode == 200){
      String res = response.body;
      dynamic data = json.decode(res);

      _posterURL = data['Search'][0]['Poster'];
      _imdbID = data['Search'][0]['imdbID'];
      return true;
    }
    else {
      print('Request failed with status: ${response.statusCode}.'); 
      return false;
    }
  }

  Future<String> addCast() async{
    var response = await http.get(
      _castURL+imdbID,
    );
    if(response.statusCode == 200){
      var document = parse(response.body);
      var tableRows = document.querySelectorAll('.cast_list tbody tr');
      for(int i = 1; i < 9; i++) {
        _cast[i-1] = tableRows[i].children[1].querySelector('a').text.trim();
      }
      return '';
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  String get posterURL {
    return _posterURL;
  }

  String get castURL {
    return _castURL;
  }

  List<String> get cast{
    return _cast;
  }

  String get imdbID {
    return _imdbID;
  }
}