import 'dart:convert';

import 'package:mevsimiwarehouse/core/_core_exports.dart';

class Login extends BaseModel {
  String? userId;
  String? email;
  String? name;
  String? surname;
  String? token;
  bool? smsVerificationStatus;

  Login({
    this.userId = "",
    this.email = "",
    this.name = "",
    this.surname = "",
    this.token,
    this.smsVerificationStatus,
  });

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['token'] = token;
    data['smsVerificationStatus'] = smsVerificationStatus;

    return jsonEncode(data);
  }

  Login.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }
  @override
  fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    token = json['token'];
    smsVerificationStatus = json['smsVerificationStatus'];
    return this;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
