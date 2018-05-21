import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import '../util/redux_controller.dart';
class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ObjectCallBack>(
        converter: (store) {
          return () => store.state.user;
        },
        builder: (ctx, ocb) {
          var _user = ocb();
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                // title: Text(_user.displayName),
                floating: true,
                // pinned: true,
                // centerTitle: true,
                elevation: 10.0,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(_user.displayName),
                  background: Image.network(_user.photoUrl),
                ),
              ),
              SliverFillViewport(
                delegate:
                    SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Container(
                    child: Center(child:Text('My DashBoard')),
                    color: Colors.orangeAccent,
                  );
                }, childCount: 2),
              ),
            ],
          );
        }
      ),
    );
  }
}