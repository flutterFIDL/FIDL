import 'package:json_annotation/json_annotation.dart';
import "package:fidl/fidl.dart";

part 'User.g.dart';

@JsonSerializable()
class User<T> extends Object {
  User();

  @GenericConverter()
  T country;
  int age;
  String name;
  String uid;
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
