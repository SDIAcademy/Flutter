import 'dart:async';

import 'schema.dart';
class MockUserRepo implements Repo{
  static final MockUserRepo _singleton = MockUserRepo._internal();
  MockUserRepo._internal();
  factory MockUserRepo() => _singleton;

  Future<List> fetchData(){
    List<UserData> data = userData.map((user) => UserData.fromMap(user)).toList();
    print(data);
    return Future.value(data);
  }
}

List<Map<String, dynamic>> userData = [
  {
  "uid": "",
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
  "uid": "",
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
  "uid": "",
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