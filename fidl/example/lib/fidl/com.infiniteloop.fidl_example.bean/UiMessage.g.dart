// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UiMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UiMessage _$UiMessageFromJson(Map<String, dynamic> json) {
  return UiMessage()
    ..message = json['message'] == null
        ? null
        : Message.fromJson(json['message'] as Map<String, dynamic>)
    ..progress = json['progress'] as int
    ..isChecked = json['isChecked'] as bool
    ..isFocus = json['isFocus'] as bool
    ..isDownloading = json['isDownloading'] as bool
    ..isPlaying = json['isPlaying'] as bool;
}

Map<String, dynamic> _$UiMessageToJson(UiMessage instance) => <String, dynamic>{
      'message': instance.message,
      'progress': instance.progress,
      'isChecked': instance.isChecked,
      'isFocus': instance.isFocus,
      'isDownloading': instance.isDownloading,
      'isPlaying': instance.isPlaying,
    };
