import 'dart:async';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  Future<Object> _user;
  @override
  initState(){
    super.initState();
    // connect to sqflite database
    _user = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black38,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/sdi_bg.png"),
            fit: BoxFit.contain,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/sdi.png"),width: 100.0),
              MaterialButton(
                height: 40.0,
                minWidth: 80.0,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Login With Google Account"),
                onPressed: () {
                  setState(() {
                });
                }
              ),
              // Form(
              //   child: Theme(
              //     data: ThemeData(
              //       brightness:  Brightness.dark,
              //       primarySwatch: Colors.teal,
              //       inputDecorationTheme: InputDecorationTheme(
              //         labelStyle: TextStyle(
              //           color: Colors.teal,
              //           fontSize: 20.0,
              //         ),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.all(40.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           TextFormField(
              //             decoration: InputDecoration(
              //               labelText: "Enter Email Address",
              //             ),
              //             keyboardType: TextInputType.emailAddress,
              //           ),
              //           TextFormField(
              //             decoration: InputDecoration(
              //               labelText: "Enter Password",
              //             ),
              //             keyboardType: TextInputType.text,
              //             obscureText: true,
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(top: 10.0),
              //           ),
              //           MaterialButton(
              //             height: 40.0,
              //             minWidth: 80.0,
              //             color: Colors.teal,
              //             textColor: Colors.white,
              //             child: Text("Login"),
              //             splashColor: Colors.greenAccent,
              //             onPressed: ()=>Navigator.of(context).pushNamed("/go"),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}