import 'dart:async';

import 'schema.dart';
class MockUserRepo implements Repo{
  static final MockUserRepo _singleton = MockUserRepo._internal();
  MockUserRepo._internal();
  factory MockUserRepo() => _singleton;

  Future<List> fetchData(){
    List<UserData> data = userData.map((user) => UserData.fromMap(user)).toList();
    return Future.value(data);
  }
}

List<Map<String, dynamic>> userData = [
  {
  "uid": "111543282107749631276",
  "name": "Zayn Jarvis",
  "email": "zaynjarvis@gmail.com",
  "interests": [
    "technology",
    "sport",
    "programming",
  ],
  "events": [
    "101",
    "102",
    "103"
  ],
  "organizations": [
    "Garage@EEE",
    "Open Source Society",
  ]
},
{
  "uid": "111543282107749631272",
  "name": "Zayn Kevin",
  "email": "zaynK@gmail.com",
  "interests": [
    "sport",
    "programming",
  ],
  "events": [
    "101"
  ],
  "organizations": [
    "Chinese Society",
    "Open Source Society",
  ]
},
{
  "uid": "111543282107749631201",
  "name": "Zayn Angel",
  "email": "zaynA@gmail.com",
  "interests": [
    "sport",
    "programming",
  ],
  "events": [
    "102",
    "103"
  ],
  "organizations": [
    "Open Source Society",
  ]
}
];

List<Map<String, dynamic>> orgData = [
  {
    "oid": "",
    "name": "Open Source Society",
    "avatar": "",
    "events": [
      "",
      ""
    ],
    "members": [
      "",
      ""
    ],
  },
  {
    "oid": "",
    "name": "Garage@EEE",
    "avatar": "",
    "events": [
      "",
      ""
    ],
    "members": [
      "",
      ""
    ],
  },
];

List<Map<String, dynamic>> eventData = [
  {
    "eid": "101",
    "name": "go",
    "date": 0,
    "description": "just go",
    "participants": [
      "",
      ""
    ]
  },
  {
    "eid": "102",
    "name": "wait",
    "date": 0,
    "description": "just wait",
    "participants": [
      "",
      ""
    ]
  },
  {
    "eid": "103",
    "name": "say",
    "date": 0,
    "description": "just say",
    "participants": [
      "",
      ""
    ]
  }
];