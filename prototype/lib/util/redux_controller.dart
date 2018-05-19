class AppState{
  final List<String> interests;
  final Object user;
  final String name;
  final String id;
  final String email;
  AppState({this.user, this.name, this.id, this.email, this.interests});
  
  AppState.initialState()
          : user = {},
            name = "",
            id = null,
            email = "",
            interests = [];

}
class AddUser {
  final Object user;
  final String name;
  final String id;
  final String email;
  AddUser({this.user, this.name, this.id, this.email});
}

class AddAction {
  final String input;
  AddAction({this.input});
}

AppState reducer(AppState state, action){
  // AddAction: 
  //     return AppState(
  //       interests: []
  //       ..addAll(state.interests)
  //       ..add(action.input)
  //     );
   if (action is AddUser){
      return AppState(
        // google Login here.
        user: action.user,
        name: action.name,
        id: action.id,
        email: action.email
      );
   }
  return AppState(user: state.user, name: state.name, interests: state.interests);
}

typedef AddView = void Function(Object user, String name, String id, String email);
class ViewModel {
  final AddView addUser;
  ViewModel({this.addUser});
}

typedef ObjectCallBack = dynamic Function();
class ViewCallBack {
  final ObjectCallBack ocb;
  ViewCallBack({this.ocb});
}