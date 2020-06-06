import 'package:http/http.dart' as http;

class FetchMovie {
  final String _imagesURL = 'https://www.google.com/search?tbm=isch&q=';
  final String _castURL = "https://www.google.com/search?q=";

  static FetchMovie _instance;
  String _title;
  
  FetchMovie._();

  static FetchMovie getInstance() {
    if(_instance == null)
      _instance = new FetchMovie._();
    return _instance;
  }
  String parseTitle() {
    List<String> splitTitle = _title.split(' ');
    String parsedTitle = '';
    splitTitle.forEach((element) {
      parsedTitle += '$element+';
    });
    return parsedTitle;
  }

  void setTitle(String title) {
    _title = title;
  }

  Future<String> getData() async{
    getCast();
    getImage();
  }
  Future<String> getCast() async{
    var response = await http.get('$_castURL');
    if(response.statusCode == 200){

    }
    else {
      return null;
    }
  }

  Future<String> getImage() async{
    var response = await http.get('$_imagesURL');
  }
}