import 'data_mock.dart';
import 'data_prod.dart';
import 'schema.dart';

enum UserProfile { MOCK, PROD }

class Injector{
  // Create singleton.
  static final Injector _singleton = Injector._internal();
  Injector._internal();
  factory Injector() => _singleton;


  static UserProfile _userProfile;

  static void configure(UserProfile userProfile) {
    _userProfile = userProfile;
  }



  Repo get repo{
    switch(_userProfile){
      case UserProfile.MOCK: return MockUserRepo();
      default: return ProdUserRepo();
    }
  }
}