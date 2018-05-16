import 'package:flutter/material.dart';
import 'snack.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       routes: <String, WidgetBuilder>{
        // "/go": (BuildContext context) => HomePage(),
        // "/1": (BuildContext context) => CalculatorPage(),
        // "/2": (BuildContext context) => ChatPage(),
      }
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  initState(){
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    );
    _iconAnimation.addListener(() => this.setState((){}));
    _iconAnimationController.forward();
  }
  @override
  void dispose(){
    _iconAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/summer.png"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    brightness:  Brightness.dark,
                    primarySwatch: Colors.teal,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Email Address",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        MaterialButton(
                          height: 40.0,
                          minWidth: 80.0,
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: Text("Login"),
                          splashColor: Colors.greenAccent,
                          onPressed: ()=>Navigator.of(context).pushNamed("/go"),
                        ),
                        Snake(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}