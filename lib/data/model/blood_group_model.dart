/// status : "success"
/// message : "Blood Group List show successfully."
/// code : 200
/// data : [{"id":65,"name":"A+","status":1,"created_at":"2023-08-09 17:09:24","updated_at":null},{"id":66,"name":"A-","status":1,"created_at":"2023-08-09 17:09:38","updated_at":"2023-08-09 17:09:52"},{"id":67,"name":"B+","status":1,"created_at":"2023-08-09 17:10:09","updated_at":null},{"id":68,"name":"B-","status":1,"created_at":"2023-08-09 17:10:25","updated_at":null},{"id":69,"name":"AB+","status":1,"created_at":"2023-08-09 17:10:52","updated_at":null},{"id":70,"name":"AB-","status":1,"created_at":"2023-08-09 17:11:04","updated_at":null},{"id":71,"name":"O+","status":1,"created_at":"2023-08-09 17:11:27","updated_at":null},{"id":72,"name":"O-","status":1,"created_at":"2023-08-09 17:11:40","updated_at":null}]

class BloodGroupModel {
  BloodGroupModel({
      String? status, 
      String? message, 
      num? code, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _code = code;
    _data = data;
}

  BloodGroupModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  num? _code;
  List<Data>? _data;
BloodGroupModel copyWith({  String? status,
  String? message,
  num? code,
  List<Data>? data,
}) => BloodGroupModel(  status: status ?? _status,
  message: message ?? _message,
  code: code ?? _code,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  num? get code => _code;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 65
/// name : "A+"
/// status : 1
/// created_at : "2023-08-09 17:09:24"
/// updated_at : null

class Data {
  Data({
      num? id, 
      String? name, 
      num? status, 
      String? createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _name = name;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  num? _status;
  String? _createdAt;
  dynamic _updatedAt;
Data copyWith({  num? id,
  String? name,
  num? status,
  String? createdAt,
  dynamic updatedAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  num? get status => _status;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}