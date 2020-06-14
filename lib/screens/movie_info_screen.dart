import 'package:flutter/material.dart';

class MovieInfoScreen extends StatefulWidget {
  final String posterURL;
  final dynamic cast;
  final String location;

  MovieInfoScreen({Key key, this.posterURL, this.cast, this.location}) : super(key: key);

  @override
  _MovieInfoScreenState createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  bool isCheckedOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 550.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.posterURL,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                        0.0,
                        0.3,
                        1.0
                      ],
                          colors: [
                        const Color(0xFF101010),
                        const Color(0x00101010),
                        const Color(0xFF101010),
                      ])),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 19.0),
                child: Center(
                  child: RaisedButton(
                    color: isCheckedOut
                        ? Theme.of(context).primaryColor
                        : Colors.red,
                    onPressed: () {
                      setState(() {
                        isCheckedOut = !isCheckedOut;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        isCheckedOut ? Text('CHECKIN') : Text('CHECKOUT'),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          isCheckedOut
                              ? Icons.subdirectory_arrow_left
                              : Icons.subdirectory_arrow_right,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Cast: '),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.cast[0]),
                      Text(widget.cast[1]),
                      Text(widget.cast[2]),
                      Text(widget.cast[3]),
                      Text(widget.cast[4]),
                      Text(widget.cast[5]),
                      Text(widget.cast[6]),
                      Text(widget.cast[7])
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
