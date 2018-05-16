import 'package:flutter/material.dart';
import 'dart:convert';

class JSONDecoder extends StatelessWidget {
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
  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("JSON reader")),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle
                    .of(context)
                    .loadString('./json/file.json'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              // Decoding
              var mydata = jsonDecode(snapshot.data.toString());
              print(snapshot);
              return ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("name: " + mydata[index]['name']),
                        Text("age: " + mydata[index]['age']),
                        Text("gender: " + mydata[index]['gender']),
                        Text("height: " + mydata[index]['height']),
                        Text("hair_color: " + mydata[index]['hair_color']),
                      ],
                    ),
                  );
                },
                itemCount: mydata == null ? 0 :mydata.length,
              );
            }
          )
        ),
      ),
    );
  }
}