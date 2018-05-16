import 'package:flutter/material.dart';
import 'Step.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Drawer")),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Zayn Jarvis"),
              accountEmail: Text("zaynjarvis@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/zoro.png"),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(backgroundColor: Colors.amber,child: Text("Z")),
              ],
            ),
            new ListTile(
              title: Text("Page 1"),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/1");
              }
            ),
            new ListTile(
              title: Text("Page 2"),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/2");
              }
            ),
            new Divider(height: 1.0),
            new ListTile(
              trailing: Icon(Icons.close),
              onTap: ()=>Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child:StepComponent(),
        ),
      )
    );
  }
}