import 'package:json_annotation/json_annotation.dart';
import "Message.dart";

part 'UiMessage.g.dart';

@JsonSerializable()
class UiMessage extends Object {
  UiMessage();

  Message message;
  int progress;
  bool isChecked;
  bool isFocus;
  bool isDownloading;
  bool isPlaying;
  
  factory UiMessage.fromJson(Map<String, dynamic> json) => _$UiMessageFromJson(json);

  Map<String, dynamic> toJson() => _$UiMessageToJson(this);
}
