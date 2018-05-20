import 'dart:async';
// import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../util/redux_controller.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class MainPage extends StatefulWidget {
  final store;
  MainPage({this.store});
  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  GoogleSignInAccount _currentUser;
  String _currentDrawer;
  List _drawerStore = [
    {
      'title': "Home",
      "callback": (){},
    },
    {
      'title': "Interests",
      "callback": (){},
    },
    {
      'title': "Events",
      "callback": (){},
    }
  ];
  @override
  void initState() {
    super.initState();
    
    _currentDrawer = "Home";

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      widget.store.dispatch(AddUser(user:_currentUser));
    });
    _googleSignIn.signInSilently();
  }

  Future<Null> _handleSignIn(viewModel) async {
    await _googleSignIn.signIn();
    viewModel.addUser(
      _currentUser
    );
  }
  Future<Null> _handleSignOut(viewModel) async {
    viewModel.addUser({});
    _googleSignIn.disconnect();
  }

  
  Widget _buildBody() {
    if (_currentUser != null) {
      List<Widget> _drawerItems = [];
      _drawerStore.forEach((item){
        _drawerItems.add(
          new Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ListTileTheme(
              selectedColor: Colors.black,
              textColor: Colors.grey,
              child: ListTile(
                selected: _currentDrawer == item['title'] ,
                title: Text(item['title']),
                onTap: (){
                  setState(() {
                    _currentDrawer = item['title'];                   
                  });
                  Navigator.of(context).pop();
                  // Navigator.of(context).push(item['callback]());
                }
              ),
            ),
          ),
        );
      });
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              StoreConnector<AppState, ObjectCallBack>(
                converter: (store) {
                  return () => store.state.user;
                },
                builder: (context, ocb) {
                  var _user = ocb();
                  return new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: UserAccountsDrawerHeader(
                      onDetailsPressed: (){
                        print(_user.email);
                      },
                      accountName: Text(
                        _user.displayName,
                        style:TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        )),
                      accountEmail: Text(
                        "\nsee profile",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.withOpacity(0.6)
                        ),
                      ),
                      currentAccountPicture: GoogleUserCircleAvatar(identity: _user),
                ),
                  );
                }
              ),
              Column(children: _drawerItems),
              Divider(height: 1.0),
              StoreConnector<AppState, ViewModel>(
                converter: (store)=>ViewModel(
                  addUser: (user) => store.dispatch(user)
                ),
                builder: (ctx, viewModel) => ListTile(
                  title: new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.redAccent,
                      )
                    ),
                  ),
                  onTap: ()=>_handleSignOut(viewModel),
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
              title: Container(
                padding: EdgeInsets.only(left: 5.0,),
                child: Text(
                  'Home',
                  style: TextStyle(
                  color: Colors.white,
                  ),
                ),
              ),
              floating: true,
              // centerTitle: true,
              elevation: 5.0,
              // expandedHeight: 50.0,
            ),
            SliverFixedExtentList(
              itemExtent: 100.0,
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('List Item: $index'),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/sdi.png"),width: 200.0),
          StoreConnector<AppState, ViewModel>(
            converter: (store) => ViewModel(
              addUser:(
                userInfo
              ) => store.dispatch(AddUser(
                user: userInfo
              ))
            ),
            builder: (context,viewModel)=> MaterialButton(
                height: 40.0,
                minWidth: 80.0,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Login With Google Account"),
                onPressed: ()=>_handleSignIn(viewModel),
              ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.teal,
      body: new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )
    );
  }
}