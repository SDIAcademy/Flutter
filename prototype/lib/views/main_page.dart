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
  @override
  void initState() {
    super.initState();
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
                  print(_user.id);
                  return UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(10.0),
                    accountName: Text(_user.displayName),
                    accountEmail: Text(_user.email, style: TextStyle(
                      color: Colors.grey.withOpacity(0.6)
                    ),),
                    currentAccountPicture: GoogleUserCircleAvatar(identity: _user),
                );
                }
              ),
              new ListTile(
                title: Text("Page 1"),
                trailing: Icon(Icons.arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                }
              ),
              new ListTile(
                title: Text("Page 2"),
                trailing: Icon(Icons.arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                }
              ),
              new Divider(height: 1.0),
              StoreConnector<AppState, ViewModel>(
                converter: (store)=>ViewModel(
                  addUser: (user) => store.dispatch(user)
                ),
                builder: (ctx, viewModel) => ListTile(
                  title: Text("Sign Out"),
                  trailing: Icon(Icons.close),
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