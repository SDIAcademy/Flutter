import 'dart:async';
// import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../util/redux_controller.dart';
import '../util/google_sign_in_button.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class MainPage extends StatefulWidget {
  final store;
  MainPage({this.store});
  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage>{
  Animation<double> animation;
  AnimationController controller;

  GoogleSignInAccount _currentUser;

  Map _currentDrawer;
  List _drawerStore = [
    {
      'title': "Home",
      "callback": (index)=>Colors.teal[index],
    },
    {
      'title': "Courses",
      "callback": (index)=>Colors.green[index],
    },
    {
      'title': "Class Room",
      "callback": (index)=>Colors.grey[index],
    }
  ];
  @override
  void initState() {
    super.initState();
    
    _currentDrawer = _drawerStore[0];

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      try{
        setState(() {
          _currentUser = account;
        });
        widget.store.dispatch(AddUser(user:_currentUser));
        } catch(e){
          print('error in initState');
          print(e);
        }
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
    try{
    viewModel.addUser({});
    _googleSignIn.disconnect();
    } catch(e){
      print('error when log out');
      print(e);
    }
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
                selected: _currentDrawer == item,
                title: Text(item['title']),
                onTap: (){
                  setState(() {
                    _currentDrawer = item;             
                  });
                  Navigator.of(context).pop();
                  // Navigator.of(context).push(item['callback‘]());
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
                        Navigator.of(context).pushNamed('/profile');
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
                  color: _currentDrawer['callback'](100 * (index % 9)),
                  // (){
                  //   _currentDrawer['callback'](100 * (index % 9));}(),
                  child: Text('List Item: $index'),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container(
        color: Color.fromRGBO(42,42,42,1.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/sdi.png"),
              width: 200.0,
              ),
            Padding(
              padding: EdgeInsets.all(5.0),
              ),
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 2000),
              child: StoreConnector<AppState, ViewModel>(
                converter: (store) => ViewModel(
                  addUser:(
                    userInfo
                  ) => store.dispatch(AddUser(
                    user: userInfo
                  ))
                ),
                builder: (context,viewModel) => MaterialButton(
                    child: button('Google', 'assets/google.png'),
                    color: Colors.white,
                    onPressed: ()=>_handleSignIn(viewModel),
                  ),
              ),
            ),
          ],
        ),
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