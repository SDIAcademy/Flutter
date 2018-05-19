import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../util/redux_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            StoreConnector<AppState, ObjectCallBack>(
              converter: (store) {
                print("here");
                // print(store.state.user);
                // return () => <String, dynamic>{ 
                //   'user': store.state.user,
                //   'name': store.state.name,
                //   'email': store.state.email,
                //   'id': store.state.id
                //   };
                return () => store.state.user;
              },
              builder: (context, ocb) {
                // Object user = jsonEncode(source);
                // print(source[1]);
                // source.id;
                
                var x = ocb();
                // x['name'];
                print(x.displayName);
                // print(x['user']);
                return UserAccountsDrawerHeader(
                  accountName:
                  Text("source.name"),
                  // Text(source[1]),
                  accountEmail: 
                  Text("user.email"),
                  // Text(source[2]),
                  currentAccountPicture: 
                  // GoogleUserCircleAvatar(identity: source[0]),
                  CircleAvatar(backgroundColor: Colors.amber,child: Text("Z")),
                  otherAccountsPictures: <Widget>[
                    CircleAvatar(backgroundColor: Colors.amber,child: Text("Z")),
                ],
              );
              }
            ),
            new ListTile(
              title: Text("Page 1"),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/1");
              }
            ),
            new ListTile(
              title: Text("Page 2"),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/2");
              }
            ),
            new Divider(height: 1.0),
            // StoreConnector<AppState, ViewModel>(
            //   converter: (store)=>ViewModel(
            //     addUser: (user) => store.dispatch(user)
            //   ),
            //   builder: (ctx, viewModel) => ListTile(
            //     title: Text("Sign Out"),
            //     trailing: Icon(Icons.close),
            //     // onTap: ()=>_handleSignOut(viewModel),
            //   ),
            // ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Container(
              padding: EdgeInsets.only(left: 10.0,),
              child: Text(
                'Home',
                style: TextStyle(
                color: Colors.white,
                ),
              ),
            ),
            floating: true,
            // centerTitle: true,
            elevation: 10.0,
            expandedHeight: 50.0,
            
          ),
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //     mainAxisSpacing: 10.0,
          //     crossAxisSpacing: 10.0,
          //     childAspectRatio: 5.0,
          //   ),
          //   delegate:
          //       SliverChildBuilderDelegate((BuildContext context, int index) {
          //     return Container(
          //       alignment: Alignment.center,
          //       color: Colors.purple[100 * (index % 9)],
          //       child: Text('Grid Item: $index'),
          //     );
          //   }, childCount: 102),
          // ),
          // SliverFillViewport(
          //   delegate:
          //       SliverChildBuilderDelegate((BuildContext context, int index) {
          //     return Container(
          //       child: Text('Sliver Fill Viewport'),
          //       color: Colors.lightBlue,
          //     );
          //   }, childCount: 2),
          // ),
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.indigo[100 * (index % 9)],
                child: Text('List Item: $index'),
              );
            }),
          )
        ],
      ),
    );
  }
}
