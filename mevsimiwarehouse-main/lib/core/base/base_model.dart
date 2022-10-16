import 'package:equatable/equatable.dart';

abstract class BaseModel<T> extends Equatable {
  String toJson();
  T fromJson(Map<String, dynamic> json);
}
