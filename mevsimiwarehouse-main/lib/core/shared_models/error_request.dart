import 'dart:convert';

import 'package:mevsimiwarehouse/core/_core_exports.dart';

class Error extends BaseModel {
  int? id;
  String? message;

  Error({this.id, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
  }

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    return jsonEncode(data);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
