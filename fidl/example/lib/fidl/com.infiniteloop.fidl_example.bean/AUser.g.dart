// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AUser _$AUserFromJson(Map<String, dynamic> json) {
  return AUser()
    ..country = json['country'] as String
    ..age = json['age'] as int
    ..name = json['name'] as String
    ..uid = json['uid'] as String;
}

Map<String, dynamic> _$AUserToJson(AUser instance) => <String, dynamic>{
      'country': instance.country,
      'age': instance.age,
      'name': instance.name,
      'uid': instance.uid,
    };
