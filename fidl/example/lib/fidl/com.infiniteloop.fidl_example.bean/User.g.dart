// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User<T> _$UserFromJson<T>(Map<String, dynamic> json) {
  return User<T>()
    ..country = GenericConverter<T>().fromJson(json['country'])
    ..age = json['age'] as int
    ..name = json['name'] as String
    ..uid = json['uid'] as String;
}

Map<String, dynamic> _$UserToJson<T>(User<T> instance) => <String, dynamic>{
      'country': GenericConverter<T>().toJson(instance.country),
      'age': instance.age,
      'name': instance.name,
      'uid': instance.uid,
    };
