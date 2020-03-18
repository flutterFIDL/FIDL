// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageContent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) {
  return MessageContent()
    ..pushContent = json['pushContent'] as String
    ..extra = json['extra'] as String
    ..mentionedTargets =
        (json['mentionedTargets'] as List)?.map((e) => e as String)?.toList()
    ..mentionedType = json['mentionedType'] as int;
}

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'pushContent': instance.pushContent,
      'extra': instance.extra,
      'mentionedTargets': instance.mentionedTargets,
      'mentionedType': instance.mentionedType,
    };
