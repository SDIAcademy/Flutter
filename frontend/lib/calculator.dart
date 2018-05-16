import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  final String state;
  CalculatorPage(this.state);
  @override
  _CalculatorPageState createState() => new _CalculatorPageState(state);
}

class _CalculatorPageState extends State<CalculatorPage> {
  String state;
  _CalculatorPageState(this.state);
  
  int num1=0, num2=0, sum=0;
  final TextEditingController t1 = TextEditingController(text: "");
  final TextEditingController t2 = TextEditingController(text: "");
  void calIni(state){
    var fn;
    int add(n1, n2){
      return n1 + n2;
    }
    int sub(n1, n2){
      return n1 - n2;
    }
    int mul(n1, n2){
      return n1 * n2;
    }
    if (state == '+')
      fn = add;
    else if (state == '-')
      fn = sub;
    else fn = mul;
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = fn(num1,num2);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: RaisedButton(
                  child: Text(state),
                  onPressed: ()=> calIni(state),
                ),
              ),
              Text(
                "= $sum",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              )
            ],
          ),
        );
  }
}
