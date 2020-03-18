import 'package:json_annotation/json_annotation.dart';
import "User.dart";

part 'AUser.g.dart';

@JsonSerializable()
class AUser extends User<String> {
  AUser();

  
  factory AUser.fromJson(Map<String, dynamic> json) => _$AUserFromJson(json);

  Map<String, dynamic> toJson() => _$AUserToJson(this);
}
