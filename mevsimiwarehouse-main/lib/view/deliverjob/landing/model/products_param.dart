import 'dart:convert';

import 'package:mevsimiwarehouse/core/_core_exports.dart';

class ProductParam extends BaseModel {
  String? field;
  String? order;
  int? page;
  int? pageSize;

  ProductParam(
      {this.field = "id",
      this.order = "descend",
      this.page = 1,
      this.pageSize = 1000});

  ProductParam.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['order'] = order;
    data['page'] = page;
    data['pageSize'] = pageSize;
    return jsonEncode(data);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    field = json['field'];
    order = json['order'];
    page = json['page'];
    pageSize = json['pageSize'];
    return this;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
