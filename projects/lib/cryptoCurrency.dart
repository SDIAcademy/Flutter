import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data/cryptoData.dart';
import 'modules/cryptoPresenter.dart';

class CryptoCurrency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? null:Colors.grey[100],
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract{
  _HomePageState() {
    this._presenter = CryptoListPresenter(this);
  }
  CryptoListPresenter _presenter;
  List<Crypto> _currencies; 
  final List<MaterialColor> _colors = [Colors.blue,Colors.green,Colors.red,Colors.purple]; 
  bool _loading;
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      _presenter.loadCurrencies();
      _loading = true;
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crypto App"),elevation: defaultTargetPlatform == TargetPlatform.android? 0.0: 5.0,),
      body: _loading? Center(child: CircularProgressIndicator()) :_crypto(),
    );
  }
  Widget _crypto(){
    return Container(
      child: new Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: _currencies.length | 0,
              // itemCount: 0,
              itemBuilder: (BuildContext context, int index){
                final Crypto currency = _currencies[index];
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
  ListTile _getListItemUI(Crypto currency, MaterialColor color){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency.name[0]),
      ),
      title: Text(currency.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(currency.price_usd,currency.percent_change_1h),
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

  @override
  void onLoadCryptoComplete(List<Crypto> items) {
    // TODO: implement onLoadCryptoComplete
    setState(() {
          _currencies = items;
          _loading = false;
        });
  }

  @override
  void onLoadCryptoError() {
    // TODO: implement onLoadCryptoError
  }
}

