// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IUserService.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FParam0 _$FParam0FromJson(Map<String, dynamic> json) {
  return FParam0(
    (json['p0'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$FParam0ToJson(FParam0 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam1 _$FParam1FromJson(Map<String, dynamic> json) {
  return FParam1(
    (json['p0'] as List)
        ?.map((e) => (e as List)?.map((e) => e as int)?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$FParam1ToJson(FParam1 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam2 _$FParam2FromJson(Map<String, dynamic> json) {
  return FParam2(
    _$enumDecodeNullable(_$EmptyEnumEnumMap, json['p0']),
  );
}

Map<String, dynamic> _$FParam2ToJson(FParam2 instance) => <String, dynamic>{
      'p0': _$EmptyEnumEnumMap[instance.p0],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EmptyEnumEnumMap = {
  EmptyEnum.none: 'none',
};

FRet3 _$FRet3FromJson(Map<String, dynamic> json) {
  return FRet3(
    json['ret'] as String,
  );
}

Map<String, dynamic> _$FRet3ToJson(FRet3 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FParam3 _$FParam3FromJson(Map<String, dynamic> json) {
  return FParam3(
    _$enumDecodeNullable(_$MessageStatusEnumMap, json['p0']),
  );
}

Map<String, dynamic> _$FParam3ToJson(FParam3 instance) => <String, dynamic>{
      'p0': _$MessageStatusEnumMap[instance.p0],
    };

const _$MessageStatusEnumMap = {
  MessageStatus.Played: 'Played',
  MessageStatus.Readed: 'Readed',
  MessageStatus.Unread: 'Unread',
  MessageStatus.AllMentioned: 'AllMentioned',
  MessageStatus.Mentioned: 'Mentioned',
  MessageStatus.Send_Failure: 'Send_Failure',
  MessageStatus.Sent: 'Sent',
  MessageStatus.Sending: 'Sending',
};

FParam4 _$FParam4FromJson(Map<String, dynamic> json) {
  return FParam4(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam4ToJson(FParam4 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam5 _$FParam5FromJson(Map<String, dynamic> json) {
  return FParam5(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam5ToJson(FParam5 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam6 _$FParam6FromJson(Map<String, dynamic> json) {
  return FParam6(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam6ToJson(FParam6 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam7 _$FParam7FromJson(Map<String, dynamic> json) {
  return FParam7(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam7ToJson(FParam7 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam8 _$FParam8FromJson(Map<String, dynamic> json) {
  return FParam8(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam8ToJson(FParam8 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam9 _$FParam9FromJson(Map<String, dynamic> json) {
  return FParam9(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam9ToJson(FParam9 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam10 _$FParam10FromJson(Map<String, dynamic> json) {
  return FParam10(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam10ToJson(FParam10 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam11 _$FParam11FromJson(Map<String, dynamic> json) {
  return FParam11(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam11ToJson(FParam11 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam12 _$FParam12FromJson(Map<String, dynamic> json) {
  return FParam12(
    json['p0'] as List,
  );
}

Map<String, dynamic> _$FParam12ToJson(FParam12 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam13 _$FParam13FromJson(Map<String, dynamic> json) {
  return FParam13(
    (json['p0'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FParam13ToJson(FParam13 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam14 _$FParam14FromJson(Map<String, dynamic> json) {
  return FParam14(
    json['p0'] as List,
  );
}

Map<String, dynamic> _$FParam14ToJson(FParam14 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam15 _$FParam15FromJson(Map<String, dynamic> json) {
  return FParam15(
    (json['p0'] as List)?.toSet(),
  );
}

Map<String, dynamic> _$FParam15ToJson(FParam15 instance) => <String, dynamic>{
      'p0': instance.p0?.toList(),
    };

FParam16 _$FParam16FromJson(Map<String, dynamic> json) {
  return FParam16(
    (json['p0'] as List)?.toSet(),
  );
}

Map<String, dynamic> _$FParam16ToJson(FParam16 instance) => <String, dynamic>{
      'p0': instance.p0?.toList(),
    };

FParam17 _$FParam17FromJson(Map<String, dynamic> json) {
  return FParam17(
    (json['p0'] as List)?.map((e) => e as String)?.toSet(),
  );
}

Map<String, dynamic> _$FParam17ToJson(FParam17 instance) => <String, dynamic>{
      'p0': instance.p0?.toList(),
    };

FParam18 _$FParam18FromJson(Map<String, dynamic> json) {
  return FParam18(
    (json['p0'] as List)?.toSet(),
  );
}

Map<String, dynamic> _$FParam18ToJson(FParam18 instance) => <String, dynamic>{
      'p0': instance.p0?.toList(),
    };

FParam19 _$FParam19FromJson(Map<String, dynamic> json) {
  return FParam19(
    (json['p0'] as List)?.map((e) => e as String)?.toSet(),
  );
}

Map<String, dynamic> _$FParam19ToJson(FParam19 instance) => <String, dynamic>{
      'p0': instance.p0?.toList(),
    };

FParam20 _$FParam20FromJson(Map<String, dynamic> json) {
  return FParam20(
    (json['p0'] as List)?.map((e) => e as String)?.toSet(),
  );
}

Map<String, dynamic> _$FParam20ToJson(FParam20 instance) => <String, dynamic>{
      'p0': instance.p0?.toList(),
    };

FParam21 _$FParam21FromJson(Map<String, dynamic> json) {
  return FParam21(
    (json['p0'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$FParam21ToJson(FParam21 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam22 _$FParam22FromJson(Map<String, dynamic> json) {
  return FParam22(
    json['p0'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$FParam22ToJson(FParam22 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam23 _$FParam23FromJson(Map<String, dynamic> json) {
  return FParam23(
    (json['p0'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$FParam23ToJson(FParam23 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam24 _$FParam24FromJson(Map<String, dynamic> json) {
  return FParam24(
    json['p0'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$FParam24ToJson(FParam24 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam25 _$FParam25FromJson(Map<String, dynamic> json) {
  return FParam25(
    json['p0'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$FParam25ToJson(FParam25 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam26 _$FParam26FromJson(Map<String, dynamic> json) {
  return FParam26(
    (json['p0'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => (e as Map<String, dynamic>)?.map(
                    (k, e) => MapEntry(k, e as String),
                  ))
              ?.toList()),
    ),
  );
}

Map<String, dynamic> _$FParam26ToJson(FParam26 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam27 _$FParam27FromJson(Map<String, dynamic> json) {
  return FParam27(
    (json['p0'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$FParam27ToJson(FParam27 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam28 _$FParam28FromJson(Map<String, dynamic> json) {
  return FParam28(
    (json['p0'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$FParam28ToJson(FParam28 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam29 _$FParam29FromJson(Map<String, dynamic> json) {
  return FParam29(
    json['p0'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$FParam29ToJson(FParam29 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam30 _$FParam30FromJson(Map<String, dynamic> json) {
  return FParam30(
    json['p0'] == null
        ? null
        : UserInfo.fromJson(json['p0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam30ToJson(FParam30 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam31 _$FParam31FromJson(Map<String, dynamic> json) {
  return FParam31(
    json['p0'] == null
        ? null
        : User.fromJson(json['p0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam31ToJson(FParam31 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam32 _$FParam32FromJson(Map<String, dynamic> json) {
  return FParam32(
    json['p0'] == null
        ? null
        : AUser.fromJson(json['p0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam32ToJson(FParam32 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FParam33 _$FParam33FromJson(Map<String, dynamic> json) {
  return FParam33(
    json['p0'] == null
        ? null
        : User.fromJson(json['p0'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam33ToJson(FParam33 instance) => <String, dynamic>{
      'p0': instance.p0,
    };

FRet34 _$FRet34FromJson(Map<String, dynamic> json) {
  return FRet34(
    json['ret'] as String,
  );
}

Map<String, dynamic> _$FRet34ToJson(FRet34 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet35 _$FRet35FromJson(Map<String, dynamic> json) {
  return FRet35(
    json['ret'] as bool,
  );
}

Map<String, dynamic> _$FRet35ToJson(FRet35 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet36 _$FRet36FromJson(Map<String, dynamic> json) {
  return FRet36(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet36ToJson(FRet36 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet37 _$FRet37FromJson(Map<String, dynamic> json) {
  return FRet37(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet37ToJson(FRet37 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet38 _$FRet38FromJson(Map<String, dynamic> json) {
  return FRet38(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet38ToJson(FRet38 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet39 _$FRet39FromJson(Map<String, dynamic> json) {
  return FRet39(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet39ToJson(FRet39 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet40 _$FRet40FromJson(Map<String, dynamic> json) {
  return FRet40(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet40ToJson(FRet40 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet41 _$FRet41FromJson(Map<String, dynamic> json) {
  return FRet41(
    json['ret'] as bool,
  );
}

Map<String, dynamic> _$FRet41ToJson(FRet41 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet42 _$FRet42FromJson(Map<String, dynamic> json) {
  return FRet42(
    (json['ret'] as List)?.map((e) => e as bool)?.toList(),
  );
}

Map<String, dynamic> _$FRet42ToJson(FRet42 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet43 _$FRet43FromJson(Map<String, dynamic> json) {
  return FRet43(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet43ToJson(FRet43 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet44 _$FRet44FromJson(Map<String, dynamic> json) {
  return FRet44(
    (json['ret'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$FRet44ToJson(FRet44 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet45 _$FRet45FromJson(Map<String, dynamic> json) {
  return FRet45(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet45ToJson(FRet45 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet46 _$FRet46FromJson(Map<String, dynamic> json) {
  return FRet46(
    (json['ret'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$FRet46ToJson(FRet46 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet47 _$FRet47FromJson(Map<String, dynamic> json) {
  return FRet47(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet47ToJson(FRet47 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet48 _$FRet48FromJson(Map<String, dynamic> json) {
  return FRet48(
    (json['ret'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$FRet48ToJson(FRet48 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet49 _$FRet49FromJson(Map<String, dynamic> json) {
  return FRet49(
    json['ret'] as int,
  );
}

Map<String, dynamic> _$FRet49ToJson(FRet49 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet50 _$FRet50FromJson(Map<String, dynamic> json) {
  return FRet50(
    (json['ret'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$FRet50ToJson(FRet50 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet51 _$FRet51FromJson(Map<String, dynamic> json) {
  return FRet51(
    (json['ret'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FRet51ToJson(FRet51 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FRet52 _$FRet52FromJson(Map<String, dynamic> json) {
  return FRet52(
    (json['ret'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FRet52ToJson(FRet52 instance) => <String, dynamic>{
      'ret': instance.ret,
    };

FParam53 _$FParam53FromJson(Map<String, dynamic> json) {
  return FParam53(
    json['p0'] as String,
    json['p1'] as int,
    _$enumDecodeNullable(_$GenderEnumMap, json['p2']),
    json['p3'] == null
        ? null
        : Conversation.fromJson(json['p3'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FParam53ToJson(FParam53 instance) => <String, dynamic>{
      'p0': instance.p0,
      'p1': instance.p1,
      'p2': _$GenderEnumMap[instance.p2],
      'p3': instance.p3,
    };

const _$GenderEnumMap = {
  Gender.FEMALE: 'FEMALE',
  Gender.MALE: 'MALE',
};
