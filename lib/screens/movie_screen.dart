import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 26.0,
              color: Colors.black,
            ),
            onPressed: () => print('pressed back'),
          ),
        ),
        body: SafeArea(
          child: ListView(
            addAutomaticKeepAlives: false,
            controller: ScrollController(initialScrollOffset: 10.0),
          ),
        ),
    );
  }
}