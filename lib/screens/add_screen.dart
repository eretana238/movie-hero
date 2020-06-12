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

  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _locationController = TextEditingController();

  String dropdownValue = 'action-adventure';
  int dropdownIndex = 0;

  List<String> genres = ['action-adventure','comedy','crime','drama','epics','horror','musicals','sci-fi','thrillers','war','westerns'];

  Future<void> _submit() async{
    if (_formKey.currentState.validate()) {
      await _fetchMovie.makeRequest('${_titleController.text}', '${_yearController.text}');
      await _fetchMovie.addCast();
    }
    CollectionReference collection = DBService.collections[genres.indexOf(dropdownValue)];
    DBService.addDocument(collection, _fetchMovie.title, _fetchMovie.year, _fetchMovie.cast, dropdownValue, _fetchMovie.posterURL, _locationController.text);
    _titleController.text = null;
    _yearController.text = null;
    _locationController.text = null;
    dropdownValue = genres[0];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        title: Text('Add Movie'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  focusColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Title',
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
                  focusColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Year',
                ),
                controller: _yearController,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  focusColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Location',
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
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                    items: genres.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                child: Center(
                  child: RaisedButton(
                    onPressed: () => _submit(),
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
    );
  }
}
