import 'dart:async';
import 'cryptoData.dart';

class MockCryptoRepository implements CryptoRepository{
  @override
  Future<List<Crypto>> fetchCurrencies(){
    return Future.value(currencies);
  }
}

var currencies = <Crypto>[
  Crypto(name:"Bitcoin", price_usd: "800.60", percent_change_1h: "-0.1"),
  Crypto(name:"CK", price_usd: "920.60", percent_change_1h: "-1.3"),
  Crypto(name:"Z", price_usd: "80.60", percent_change_1h: "2.1")
];