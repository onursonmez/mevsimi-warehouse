import 'dart:convert';

import 'package:mevsimiwarehouse/core/base/base_model.dart';
import 'package:mevsimiwarehouse/core/constants/_constants_exports.dart';

import '_shared_models_exports.dart';

class Product extends BaseModel {
  int? id;
  String? productName;
  String? productVariantName;
  int? statusId;
  String? statusName;
  String? shelfNumber;
  bool? isFirstOrder;
  List<Items>? items;
  ProductStatus? productStatus;

  Product(
      {this.id,
      this.productName,
      this.statusId,
      this.productVariantName,
      this.statusName,
      this.shelfNumber,
      this.isFirstOrder,
      this.productStatus = ProductStatus.EMPTY,
      this.items});

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productName'] = productName;
    data['productVariantName'] = productVariantName;
    data['statusId'] = statusId;
    data['statusName'] = statusName;
    data['shelfNumber'] = shelfNumber;
    data['isFirstOrder'] = isFirstOrder;
    if (items != null) {
      data['items'] = items!.map((v) => v.toMap()).toList();
    }
    return jsonEncode(data);
  }

  Product.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }
  @override
  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    statusId = json['statusId'] ?? 1;
    productVariantName = json['productVariantName'];
    statusName = json['statusName'];
    shelfNumber = json['shelfNumber'] ?? "";
    isFirstOrder = json['isFirstOrder'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    return this;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
