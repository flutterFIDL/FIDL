// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IConversationService.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FParam0 _$FParam0FromJson(Map<String, dynamic> json) {
  return FParam0(
    json['p0'] == null
        ? null
        : Conversation.fromJson(json['p0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam0ToJson(FParam0 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FRet1 _$FRet1FromJson(Map<String, dynamic> json) {
  return FRet1(
    json['ret'] as String,
  );
}

Map<String, dynamic> _$FRet1ToJson(FRet1 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet2 _$FRet2FromJson(Map<String, dynamic> json) {
  return FRet2(
    (json['ret'] as List)
        ?.map((e) =>
            e == null ? null : UiMessage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FRet2ToJson(FRet2 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FParam3 _$FParam3FromJson(Map<String, dynamic> json) {
  return FParam3(
    json['p0'] as String,
  );
}

Map<String, dynamic> _$FParam3ToJson(FParam3 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FRet4 _$FRet4FromJson(Map<String, dynamic> json) {
  return FRet4(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet4ToJson(FRet4 instance) => <String, dynamic>{
      'ret': instance.ret,
    };
