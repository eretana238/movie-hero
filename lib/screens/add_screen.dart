import 'package:flutter/material.dart';
import 'package:movie_hero/services/fetch_movie.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key key}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final FetchMovie _fetchMovie = FetchMovie.getInstance();

  final titleController = TextEditingController();
  final yearController = TextEditingController();

  String dropdownValue = 'Action-Adventure';

  // Future<void> _addDocument 
  // TODO : start adding new documents in collections

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    yearController.dispose();
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
                controller: titleController,
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter year';
                  }
                  return null;
                },
                controller: yearController,
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
                    items: <String>[
                      'Action-Adventure','Comedy','Crime','Drama','Epics','Horror','Musicals','Sci-fi','Thrillers','War','Westerns'
                    ]
                    .map<DropdownMenuItem<String>>((String value) {
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _fetchMovie.title = '${titleController.text}';
                        _fetchMovie.year = '${yearController.text}';
                        _fetchMovie.makeRequest();
                        // print(data[0]['Title'] + ' ' + data[0]['Year']);
                      }
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
    );
  }
}
