import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_hero/services/db_service.dart';
import 'package:movie_hero/services/fetch_movie.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key key}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final FetchMovie _fetchMovie = FetchMovie.getInstance();
  bool loading = false;

  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _locationController = TextEditingController();

  String dropdownValue = 'action-adventure';
  int dropdownIndex = 0;

  List<String> genres = [
    'action-adventure',
    'comedy',
    'crime',
    'drama',
    'epics',
    'horror',
    'musicals',
    'sci-fi',
    'thrillers',
    'war',
    'westerns'
  ];
  /*
    fetches information from movie database api, and adds it in the movie hero database
  */
  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      loading = true;
      await _fetchMovie.makeRequest(
          '${_titleController.text}', '${_yearController.text}');
      await _fetchMovie.addCast();
    }
    CollectionReference collection =
        DBService.collections[genres.indexOf(dropdownValue) + 1];
    DBService.addDocument(
        collection,
        _fetchMovie.title,
        _fetchMovie.year,
        _fetchMovie.cast,
        dropdownValue,
        _fetchMovie.posterURL,
        _locationController.text);
    setState(() {
      _formKey.currentState.reset();
      loading = false;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _yearController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        title: Text('Add Movie'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (!loading) Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Add title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  controller: _titleController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.access_time,
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Add year (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  controller: _yearController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on,
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Add location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some location';
                    }
                    return null;
                  },
                  controller: _locationController,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Center(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        // color: Theme.of(context).primaryColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items:
                          genres.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('ADD'),
                          Icon(
                            Icons.add,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
