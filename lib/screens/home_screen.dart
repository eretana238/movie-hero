import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Icon(
            Icons.add,
            color: Colors.black,
          ),
        ],
        leading: Icon(
          Icons.apps,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(

        ),
      )
    );
  }
}