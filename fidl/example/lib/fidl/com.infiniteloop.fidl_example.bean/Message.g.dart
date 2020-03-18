// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..serverTime = json['serverTime'] as int
    ..messageUid = json['messageUid'] as int
    ..status = _$enumDecodeNullable(_$MessageStatusEnumMap, json['status'])
    ..direction =
        _$enumDecodeNullable(_$MessageDirectionEnumMap, json['direction'])
    ..content = json['content'] == null
        ? null
        : MessageContent.fromJson(json['content'] as Map<String, dynamic>)
    ..toUsers = (json['toUsers'] as List)?.map((e) => e as String)?.toList()
    ..sender = json['sender'] as String
    ..conversation = json['conversation'] == null
        ? null
        : Conversation.fromJson(json['conversation'] as Map<String, dynamic>)
    ..messageId = json['messageId'] as int;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'serverTime': instance.serverTime,
      'messageUid': instance.messageUid,
      'status': _$MessageStatusEnumMap[instance.status],
      'direction': _$MessageDirectionEnumMap[instance.direction],
      'content': instance.content,
      'toUsers': instance.toUsers,
      'sender': instance.sender,
      'conversation': instance.conversation,
      'messageId': instance.messageId,
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

const _$MessageDirectionEnumMap = {
  MessageDirection.Receive: 'Receive',
  MessageDirection.Send: 'Send',
};
