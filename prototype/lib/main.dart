import 'package:flutter/material.dart';
import 'util/redux_controller.dart';

// views
import './views/main_page.dart';
import './views/user_profile.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Tribes extends StatelessWidget {
  // Initialize Redux Store
  final store = Store<AppState>(reducer, initialState: AppState.initialState());
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Tribes",
        home: MainPage(store:store),
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Brela',
        ),
        routes: <String, WidgetBuilder>{
          "/main": (BuildContext context) => MainPage(store:store),
          "/profile": (BuildContext context) => UserProfile(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


void main() => runApp(Tribes());
