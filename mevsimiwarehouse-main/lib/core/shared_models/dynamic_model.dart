import 'dart:convert';

import 'package:mevsimiwarehouse/core/_core_exports.dart';

class DynmicModel extends BaseModel {
  // ignore: prefer_typing_uninitialized_variables
  var dynmicValue;
  DynmicModel({this.dynmicValue});

  DynmicModel.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }
  @override
  fromJson(Map<String, dynamic> json) {
    dynmicValue = jsonEncode(json);
  }

  @override
  String toJson() {
    return jsonDecode(dynmicValue);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
