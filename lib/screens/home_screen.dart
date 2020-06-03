import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.apps,
              color: Colors.black,
            ),
            onPressed: () => print('pressed apps'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 28.0,
                  ),
                  onPressed: () => print('pressed add'),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(),
        ));
  }
}
