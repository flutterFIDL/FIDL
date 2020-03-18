import 'package:json_annotation/json_annotation.dart';
import "MessageStatus.dart";
import "MessageDirection.dart";
import "MessageContent.dart";
import "Conversation.dart";

part 'Message.g.dart';

@JsonSerializable()
class Message extends Object {
  Message();

  int serverTime;
  int messageUid;
  MessageStatus status;
  MessageDirection direction;
  MessageContent content;
  List<String> toUsers;
  String sender;
  Conversation conversation;
  int messageId;
  
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
