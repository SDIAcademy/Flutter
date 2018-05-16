import 'package:flutter/material.dart';
import 'calculator.dart';

class TabComponent extends StatefulWidget {
  @override
  _TabComponentState createState() => new _TabComponentState();
}

class _TabComponentState extends State<TabComponent> with SingleTickerProviderStateMixin{
  TabController t;
  void initState(){
    super.initState();
    t = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: TabBarView(
          children: <Widget>[
            CalculatorPage('+'),
            CalculatorPage('-'),
            CalculatorPage('*'),
          ],
          controller: t,
        ),
        bottomNavigationBar: Material(
          color: Colors.lightBlue,
          child: TabBar(
            controller: t,
            labelColor: Colors.red,
            indicatorColor: Colors.red[300],
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.add),
              ),
              Tab(
                icon: Icon(Icons.remove),
              ),
              Tab(
                icon: Icon(Icons.clear),
              ),
            ],
          ),
        ),
    );
  }
}
