// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IChatService.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FRet0 _$FRet0FromJson(Map<String, dynamic> json) {
  return FRet0(
    json['ret'] as bool,
  );
}

Map<String, dynamic> _$FRet0ToJson(FRet0 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FParam0 _$FParam0FromJson(Map<String, dynamic> json) {
  return FParam0(
    json['p0'] == null
        ? null
        : User.fromJson(json['p0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam0ToJson(FParam0 instance) => <String, dynamic>{
      'p0': instance.p0,
    };
