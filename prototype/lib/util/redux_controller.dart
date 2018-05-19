class AppState{
  final List<String> interests;
  final Object user;
  AppState({this.user, this.interests});
  
  AppState.initialState()
          : user = null,
            interests = [];

}
class AddUser {
  final Object user;
  AddUser({this.user});
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
        user: action.user
      );
   }
  return AppState(user: state.user, interests: state.interests);
}

typedef AddView = void Function(Object user);
class ViewModel {
  final AddView addUser;
  ViewModel({this.addUser});
}

typedef ObjectCallBack = dynamic Function();
class ViewCallBack {
  final ObjectCallBack ocb;
  ViewCallBack({this.ocb});
}