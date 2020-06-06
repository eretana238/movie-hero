import 'package:http/http.dart' as http;
import 'dart:io' show File;
import 'dart:convert' show json;
// import 'package:html/dom.dart';
// import 'package:html/dom_parsing.dart';
// import 'package:html/parser.dart' as parser;


class FetchMovie{
  final String _imagesURL = 'https://customsearch.googleapis.com/customsearch/v1?cx=$_cx&imgSize=MEDIUM&q=$_query&searchType=image&key=$_key';
  // final String _castURL = "https://www.google.com/search?q=";

  static FetchMovie _instance;
  String _title;
  String _query;
  static String _cx;
  static String _key;
  
  FetchMovie._();

  static FetchMovie getInstance() {
    if(_instance == null)
      _instance = new FetchMovie._();
    return _instance;
  }
  /*
  * Makes regular title in the google query string format: (Hello+world+2)
  */
  String parseTitle() {
    List<String> splitTitle = _title.split(' ');
    _query = '';
    splitTitle.forEach((element) {
      _query += '$element%20';
    });
    _query += 'poster';
    return _query;
  }

  void setTitle(String title) {
    _title = _title;
    parseTitle();
  }

  void setJSONKeys() async{
    Map x = await json.decode(await new File('../keys.json').readAsString());
  }

  Future<String> getImage() async{
    var response = await http.get('$_imagesURL');
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