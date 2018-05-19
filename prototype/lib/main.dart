import 'package:flutter/material.dart';
import 'util/redux_controller.dart';

// +views
import './views/login_page.dart';
import './views/main_page.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Tribes extends StatelessWidget {
  // store for app.
  final store = Store<AppState>(reducer, initialState: AppState.initialState());
  // do local database check
  // checkfor account in firebase
  // give result to isLogin
  final isLogin = false;
  @override
  Widget build(BuildContext context) {
    return 
    StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Tribes",
        // do redux store here.
        // give back result for isLogin;
        home: isLogin ? MainPage() : LoginPage(),
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => LoginPage(),
          "/main": (BuildContext context) => MainPage(),
          // "/2": (BuildContext context) => ChatPage(),
        }
      ),
    );
  }
}


void main() => runApp(Tribes());
