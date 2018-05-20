import 'dart:async';

class UserData {
  String uid, name, email;
  List interests, events, organizations;
  UserData({this.uid, this.name, this.email, 
            this.interests, this.events, 
            this.organizations});
  UserData.fromMap(Map<String, dynamic> map)
          : uid = map['uid'],
            name = map['name'],
            email = map['email'],
            interests = map['interests'],
            events = map['events'],
            organizations = map['organizations'];
}

class OrgData {
  String oid, name, avatar;
  List events, members;
  OrgData({ this.oid, this.name, this.avatar, 
            this.events, this.members});
  OrgData.fromMap(Map<String, dynamic> map)
          : oid = map['oid'],
            name = map['name'],
            avatar = map['avatar'],
            events = map['events'],
            members = map['members'];
}

class EventData {
  String eid, name, description;
  List participants;
  int date;
  EventData({ this.eid, this.name, this.description, 
            this.participants, this.date});
  EventData.fromMap(Map<String, dynamic> map)
          : eid = map['eid'],
            name = map['name'],
            description = map['description'],
            participants = map['participants'],
            date = map['date'];
}

abstract class Repo{
  Future<List> fetchData();
}