import '../data/cryptoData.dart';
import '../dependencyInjection.dart';

abstract class CryptoListViewContract{
  void onLoadCryptoComplete(List<Crypto> items);
  void onLoadCryptoError();
}

class CryptoListPresenter{
  CryptoListViewContract _view;
  CryptoRepository _repo;

  CryptoListPresenter(this._view) {
    _repo = Injector().cryptoRepository;
  }

  void loadCurrencies(){
    _repo.fetchCurrencies()
          .then((c)=>_view.onLoadCryptoComplete(c))
          .catchError((onError)=>_view.onLoadCryptoError());
  }
}