import './data/cryptoData.dart';
import './data/cryptoDataMock.dart';
import './data/cryptoDataProd.dart';
enum Flavor { MOCK, PROD }

class Injector{
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector(){
    return _singleton;
  }

  Injector._internal();

  CryptoRepository get cryptoRepository{
    switch(_flavor){
      case Flavor.MOCK: return MockCryptoRepository();
      default: return ProdCryptoRepository();
    }
  }
}