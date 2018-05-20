import 'dart:async';

import 'schema.dart';
class ProdUserRepo implements Repo{
  @override
  Future<List> fetchData() {
    return Future.value();
  }
}