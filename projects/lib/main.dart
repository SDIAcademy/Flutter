import 'package:flutter/material.dart';
import './cryptoCurrency.dart';
import 'dependencyInjection.dart';

void main() async {
  Injector.configure(Flavor.PROD);
  runApp(CryptoCurrency());
}