import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HTTPFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://swapi.co/api/people';
  List mydata;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      // Encode URL
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );
    print(response.body);
    setState((){
      var toJson = jsonDecode(response.body);
      mydata = toJson['results'];
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("HTTP GET request")),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Text("Hello"),
                        // Text("age: " + mydata[index]['age']),
                        Text("name: " + mydata[index]['name']),
                        // Text("gender: " + mydata[index]['gender']),
                        // Text("height: " + mydata[index]['height']),
                        // Text("hair_color: " + mydata[index]['hair_color']),
                      ],
                    ),
                  );
                },
                itemCount: mydata == null ? 0 :mydata.length,
                // itemCount: 1,
              ),
    );
  }
}