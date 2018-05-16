import 'package:flutter/material.dart';
import './cryptoCurrency.dart';

void main() async {
  List currencies = await getCurrencies();
  print(currencies);
  runApp(CryptoCurrency(currencies));
}