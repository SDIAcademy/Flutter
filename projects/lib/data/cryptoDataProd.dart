import 'dart:async';
import 'cryptoData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdCryptoRepository implements CryptoRepository{
  @override
  Future<List<Crypto>> fetchCurrencies() async{
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(cryptoUrl);
    final List responseBody = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) 
      throw FetchDataException("An Error Occured, [Status $statusCode]");
    return responseBody.map((c) => Crypto.fromMap(c)).toList();
  }
}