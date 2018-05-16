import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoCurrency extends StatelessWidget {
  final List _currencies;
  @override
  CryptoCurrency(this._currencies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? null:Colors.grey[100],
      ),
      home: HomePage(this._currencies),
    );
  }
}

Future<List> getCurrencies() async{
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(cryptoUrl);
    return jsonDecode(response.body);
}

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => new _HomePageState(this.currencies);
}

class _HomePageState extends State<HomePage> {
  final List<MaterialColor> _colors = [Colors.blue,Colors.green,Colors.red,Colors.purple];
  final List currencies;
  _HomePageState(this.currencies);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crypto App"),elevation: defaultTargetPlatform == TargetPlatform.android? 0.0: 5.0,),
      body: _crypto(),
    );
  }
  Widget _crypto(){
    return Container(
      child: new Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: this.currencies.length | 0,
              // itemCount: 0,
              itemBuilder: (BuildContext context, int index){
                final Map currency = this.currencies[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUI(currency, color);
                // return Text("hi");
              },
            )
          ),
        ],
      )
    );
  }
  ListTile _getListItemUI(Map currency, MaterialColor color){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(currency['price_usd'],currency['percent_change_1h']),
      isThreeLine: false,
    );
  }

  Widget _getSubtitleText(String price, String percent){
    TextSpan priceTextWidget = TextSpan(text: "\$$price\n",
                                        style: TextStyle(color: Colors.black));
    String percentText = "1 hour: $percent";
    TextSpan persentWidget;
    if (double.parse(percent)>0){
      persentWidget = TextSpan(text: percentText,
      style: TextStyle(color: Colors.green));
    }
    else{
      persentWidget = TextSpan(text: percentText,
      style: TextStyle(color: Colors.red));
    }
    return RichText(
      text: TextSpan(
        children: [priceTextWidget, persentWidget]
      ),
    );
                      
  }



}

