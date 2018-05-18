import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

Future<void> main() async{
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'DB',
    options: FirebaseOptions(
            googleAppID: '1:1081776211548:android:a8a6f5983ca93d9b',
            apiKey: 'AIzaSyDET4eaCfWJ-VgWMKMfNVCCeazY_Bk9bIg',
            databaseURL: 'https://myflutter-34cd5.firebaseio.com',
          ),
  );
  runApp(MaterialApp(
    title: 'Flutter Demo',
    home: Home(app: app),
    ));
}

class Home extends StatefulWidget {
  Home({this.app});
  final FirebaseApp app;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> items = List();
  Item item;
  int _counter;
  DatabaseReference _counterRef;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    item = Item("", "");
    // final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    itemRef = database.reference().child('items');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    itemRef.onChildAdded.listen(_onEntryAdded);
    _counterRef.onValue.listen((Event event) {
      setState(() {
        _counter = event.snapshot.value ?? 0;
      });
    });
    // itemRef.onChildChanged.listen(_onChanged);
    try {
      database.reference().child('items').once().then((DataSnapshot snapshot) {
      print('Connected to item database and read ${snapshot.value}');
    });
    } catch(e){
      print(e);
    }
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    itemRef.keepSynced(true);


  }
  _onEntryAdded(Event event){
    setState(() {
          items.add(Item.fromSnapshot(event.snapshot));
        });
  }
  // _onChanged(Event event){
  //   var old = items.singleWhere((entry){
  //     return entry.key == event.snapshot.key;
  //   });
  //   setState((){
  //     items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
  //   });
  // }

  void handleSubmit() async{
    final FormState form = formKey.currentState;
    // Increment counter in transaction.
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed && form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
      print(transactionResult.dataSnapshot.value);
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase")),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Flexible(flex: 0,child: firstFlex(),),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: 
              (BuildContext ctx, DataSnapshot snapshot, 
              Animation<double> animation, int index){
                return ListTile(
                  leading: Icon(Icons.message),
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),
                );
              },
            ),
          ),
        ],
      )
    );
  }
  Widget firstFlex(){
    return Form(
      key: formKey,
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.info),
            title: TextFormField(
              initialValue: '',
              onSaved: (val) => item.title = val,
              validator: (val) => val == "" ? val : null,
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: TextFormField(
              initialValue: '',
              onSaved: (val) => item.body = val,
              validator: (val) => val == "" ? val : null,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: handleSubmit,
          ),
        ],
      ),
    );
  }
}



class Item {
  String key;
  String title;
  String body;

  Item(this.title,this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        body = snapshot.value['body'];

  toJson() {
    return {
      "title": title,
      "body": body,
    };
  }
}