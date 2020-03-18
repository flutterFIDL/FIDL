import 'package:json_annotation/json_annotation.dart';

part 'MessageContent.g.dart';

@JsonSerializable()
class MessageContent extends Object {
  MessageContent();

  String pushContent;
  String extra;
  List<String> mentionedTargets;
  int mentionedType;
  
  factory MessageContent.fromJson(Map<String, dynamic> json) => _$MessageContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}
