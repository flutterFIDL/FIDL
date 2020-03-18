import 'package:json_annotation/json_annotation.dart';
import "../com.infiniteloop.fidl_example.bean.Conversation/ConversationType.dart";

part 'Conversation.g.dart';

@JsonSerializable()
class Conversation extends Object {
  Conversation();

  String target;
  ConversationType type;
  
  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
