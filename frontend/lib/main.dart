import 'package:flutter/material.dart';
import './Login.dart';
import './calculator.dart';
import './ChatApp.dart';
import './drawerflutter.dart';

void main() => runApp(Login());
//void main() => runApp(Calculator());
// void main() => runApp(ChatApp());
// void main() => runApp(DrawerFlutter());
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       routes: <String, WidgetBuilder>{
        "/go": (BuildContext context) => HomePage(),
        "/1": (BuildContext context) => CalculatorPage(),
        "/2": (BuildContext context) => ChatPage(),
      }
    );
  }
}