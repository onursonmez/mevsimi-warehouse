import 'dart:convert';

import '../_core_exports.dart';

class ProductResult extends BaseModel {
  int? total;
  List<Product>? product;

  ProductResult({this.total, this.product});

  ProductResult.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (product != null) {
      data['items'] = product!.map((v) => v.toJson()).toList();
    }
    return jsonEncode(data);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['items'] != null) {
      product = <Product>[];
      json['items'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    return this;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
