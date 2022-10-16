import 'dart:convert';

import 'package:mevsimiwarehouse/core/base/base_model.dart';

class LoginParam extends BaseModel {
  String? email;
  String? password;

  LoginParam({this.email, this.password});

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;

    return jsonEncode(data);
  }

  LoginParam.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }
  @override
  fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    return this;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
