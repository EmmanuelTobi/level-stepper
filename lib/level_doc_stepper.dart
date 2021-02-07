class DocVerification {
  List<LevelData> levelData;

  DocVerification({this.levelData});

  DocVerification.fromJson(Map<String, dynamic> json) {
    if (json['level_data'] != null) {
      levelData = new List<LevelData>();
      json['level_data'].forEach((v) {
        levelData.add(new LevelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.levelData != null) {
      data['level_data'] = this.levelData.map((v) => v.toJson()).toList();
    }
    return data;
  }


  Map<String, dynamic> level_data = {
    "level_data":[
      {
        "id" : 1,
        "name" : "Level 1",
        "level_description" : "Bank Transfer",
        "docs" : [{
          "doc_name" : "complete your profile",
          "isCompleted": true
        },
        {
          "doc_name" : "Verify BVN",
          "isCompleted": true
        },
        {
          "doc_name" : "Verify phone number",
          "isCompleted": true
        }]
      },
      {
        "id" : 2,
        "name" : "Level 2",
        "level_description" : "Bank Transfer",
        "docs" : [{
          "doc_name" : "Verify bio",
          "isCompleted": true
        }]
      },
      {
        "id" : 3,
        "name" : "Level 3",
        "level_description" : "Bank Transfer",
        "docs" : [{
          "doc_name" : "Verify residential address",
          "isCompleted": false
        }]
      }
    ]
  };

}

class LevelData {
  int id;
  String name;
  List<Docs> docs;

  LevelData({this.id, this.name, this.docs});

  LevelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['docs'] != null) {
      docs = new List<Docs>();
      json['docs'].forEach((v) {
        docs.add(new Docs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.docs != null) {
      data['docs'] = this.docs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  String docName;
  bool isCompleted;

  Docs({this.docName, this.isCompleted});

  Docs.fromJson(Map<String, dynamic> json) {
    docName = json['doc_name'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doc_name'] = this.docName;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}