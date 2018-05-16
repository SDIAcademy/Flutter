import 'package:flutter/material.dart';

//void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "calculator",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CalculatorPage(),
    );
  }
}
class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => new _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  int num1=0, num2=0, sum=0;
  final TextEditingController t1 = TextEditingController(text: "0");
  final TextEditingController t2 = TextEditingController(text: "0");
  void calIni(fn){
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = fn(num1,num2);
    });
  }
  int add(n1, n2){
      return n1 + n2;
  }
  int sub(n1, n2){
    return n1 - n2;
  }
  int mul(n1, n2){
    return n1 * n2;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Number 1",
                ),
                controller: t1,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Number two",
                ),
                controller: t2,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("+"),
                      onPressed: ()=> calIni(add),
                    ),
                    RaisedButton(
                      child: Text("-"),
                      onPressed: ()=>calIni(sub),
                    ),
//                    RaisedButton(
//                      child: Text("*"),
//                      onPressed: (){},
//                    ),
                    RaisedButton(
                      child: Text("/"),
                      onPressed: ()=>calIni(mul),
                    ),
                  ],
                ),
              ),
              Text(
                "Output $sum",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              )
            ],
          ),
        )
    );
  }
}
