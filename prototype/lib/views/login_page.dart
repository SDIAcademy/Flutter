import 'dart:async';
// import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'main_page.dart';

import '../util/redux_controller.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      print('changed');
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<Null> _handleSignIn(viewModel) async {
    try {
      await _googleSignIn.signIn();
      // print(_currentUser);

      viewModel.addUser(
        _currentUser
      );
      // viewModel.addUser(_currentUser);
      print('success');
    } catch (error) {
      print('error');
      print(error);
    }
  }
  // toJson(user){
  //   return {
  //     "user": user,
  //     "name": user.displayName,
  //     "id": user.id,
  //     "email": user.email,
  //     "photo": user.photoUrl
  //   };
  // }
  // Future<Null> _handleSignOut(viewModel) async {
  //   print(3);
  //   viewModel.addUser({});
  //   print(4);
  //   _googleSignIn.disconnect();
  // }

  Widget _buildBody() {
    if (_currentUser != null) {
      return MainPage();
      // new Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: <Widget>[
      //     new ListTile(
      //       leading: new GoogleUserCircleAvatar(
      //         identity: _currentUser,
      //       ),
      //       title: new Text(_currentUser.displayName + _currentUser.id),
      //       subtitle: new Text(_currentUser.email),
      //     ),
      //     const Text("Signed in successfully."),
      //     StoreConnector<AppState, ViewModel>(
      //       converter: (store) => ViewModel(
      //         addUser: (userInfo) => store.dispatch(AddUser(
      //             user: userInfo,
      //           ))
      //       ),
      //       builder: (context,viewModel)=> MaterialButton(
      //           height: 40.0,
      //           minWidth: 80.0,
      //           color: Colors.teal,
      //           textColor: Colors.white,
      //           child: Text("Login Out"),
      //           onPressed: ()=>_handleSignOut(viewModel),
      //         ),
      //     ),
      //   ],
      // );
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
        ));
  }
}