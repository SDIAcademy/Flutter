import 'package:flutter/material.dart';


Widget buttonRow = Container(
  width: 150.0,
  child: Center(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/google_sign_in.png',
          width: 20.0,
          // fit: BoxFit.contain,
        ),
        Padding(
          child: Text(
          "Sign in with Google",
          style:  TextStyle(
            fontFamily: 'Roboto',
            color: const Color.fromRGBO(68, 68, 76, .8),
          ),
        ),
          padding: new EdgeInsets.only(left: 20.0),
        ),
      ],
    ),
  ),
);