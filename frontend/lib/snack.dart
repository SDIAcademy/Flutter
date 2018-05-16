// This section is more for notifications.

import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  final AlertDialog dialog = AlertDialog(
    content: Text(
      "Alert!",
      style: TextStyle(fontSize: 20.0),
    ),
    title: Text("Hi"),
  );
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.all(3.0),
          ),
          RaisedButton(
          child:Text(
            "Snack Bar",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          color:Colors.white,
          onPressed: () => Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('This is a Snack Bar.'),
              duration: Duration(seconds: 3),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3.0),
        ),
        RaisedButton(
          child:Text(
            "Alert",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          color:Colors.white,
          onPressed: ()=>showDialog(context:context, child: dialog),
        ),
        ],
      ),
    );
  }
}

