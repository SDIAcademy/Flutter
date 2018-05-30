import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movie Searcher",
        theme: ThemeData.dark(),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Movie Seracher App"),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.home),
                    text: 'Home Page',
                  ),
                  Tab(
                    icon: Icon(Icons.favorite),
                    text: "Favorites",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                HomePage(),
                SecondPage(),
              ],
            ),
          ),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var _applicationState;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      print('init');
      WidgetsBinding.instance.addObserver(this);
    }

    @override
      void dispose() {
        WidgetsBinding.instance.removeObserver(this);
        print('dispose');
        // TODO: implement dispose
        super.dispose();
      }

      @override
        void didChangeAppLifecycleState(AppLifecycleState state) {
          print(state);
          // TODO: implement didChangeAppLifecycleState
          setState(() {
                      _applicationState = state;
                    });
        }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('state is $_applicationState'),
    ));
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => new _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with WidgetsBindingObserver {
  var _applicationState;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      WidgetsBinding.instance.addObserver(this);
    }

    @override
      void dispose() {
        WidgetsBinding.instance.removeObserver(this);
        // TODO: implement dispose
        super.dispose();
      }

      @override
        void didChangeAppLifecycleState(AppLifecycleState state) {
          // TODO: implement didChangeAppLifecycleState
          setState(() {
                      _applicationState = state;
                    });
        }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('state is $_applicationState'),
    ));
  }
}
