import 'dart:convert';

import 'package:mevsimiwarehouse/core/base/base_model.dart';

class Items extends BaseModel implements Comparable {
  int? id;
  String? name;
  double? quantity;
  bool? isSelected;
  bool? isRemove;
  bool? cacheIsSelected;


  Items(
      {this.id,
      this.name,
      this.quantity,
      this.isSelected,
      this.cacheIsSelected,
});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['isSelected'] = isSelected != cacheIsSelected ? cacheIsSelected : null;
    return data;
  }

  @override
  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['isSelected'] = isSelected != cacheIsSelected ? cacheIsSelected : null;
    return jsonEncode(data);
  }

  Items.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }
  @override
  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'] == null
        ? null
        : double.parse(json['quantity'].toString());
    isSelected = json['isSelected'];
    cacheIsSelected = isSelected;
    return this;
  }

  @override
  int compareTo(other) {
    return name!.compareTo(other.name);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
