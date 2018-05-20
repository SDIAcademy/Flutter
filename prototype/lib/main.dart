import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


// views
import './views/main_page.dart';

// data
import './data/dependency_injection.dart';
import './data/schema.dart';


// util
import 'util/redux_controller.dart';

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
        ),
        routes: <String, WidgetBuilder>{
          "/main": (BuildContext context) => MainPage(store:store),
        }
      ),
    );
  }
}


void main() {
  Injector.configure(UserProfile.MOCK);
  // Repo rp = Injector().repo;
  // rp.fetchData();
    // .then((data)=>print);

  return runApp(Tribes());
} 
