import 'dart:async';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fidl/fidl.dart';
import "../com.infiniteloop.fidl_example.bean/Conversation.dart";
import "../com.infiniteloop.fidl_example.bean/UiMessage.dart";

part 'IConversationService.g.dart';

class IConversationService {
  static const String CHANNEL_NAME = 'com.infiniteloop.fidl_example.IConversationService';
  static const MethodChannel _channel =
      const MethodChannel(CHANNEL_NAME, const MultiMethodCodec());

  static Future<void> setupConversation(Conversation conversation) async {
    var p0 = FParam0(conversation).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('setupConversation', param);
  }
  static Future<String> getConversationDesc() async {
    var ret = await _channel.invokeMethod('getConversationDesc');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet1.fromJson(json).ret;
  }
  static Future<List<UiMessage>> getMessages() async {
    var ret = await _channel.invokeMethod('getMessages');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet2.fromJson(json).ret;
  }
  static Future<void> sendMessage(String message) async {
    var p0 = FParam3(message).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('sendMessage', param);
  }
  static Future<int> getMessageCount() async {
    var ret = await _channel.invokeMethod('getMessageCount');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet4.fromJson(json).ret;
  }

}

@JsonSerializable()
class FParam0 {
  FParam0(this.p0);

  Conversation p0;

  factory FParam0.fromJson(Map<String, dynamic> json) => _$FParam0FromJson(json);

  Map<String, dynamic> toJson() => _$FParam0ToJson(this);
}
@JsonSerializable()
class FRet1 {
  FRet1(this.ret);

  String ret;

  factory FRet1.fromJson(Map<String, dynamic> json) => _$FRet1FromJson(json);

  Map<String, dynamic> toJson() => _$FRet1ToJson(this);
}
@JsonSerializable()
class FRet2 {
  FRet2(this.ret);

  List<UiMessage> ret;

  factory FRet2.fromJson(Map<String, dynamic> json) => _$FRet2FromJson(json);

  Map<String, dynamic> toJson() => _$FRet2ToJson(this);
}
@JsonSerializable()
class FParam3 {
  FParam3(this.p0);

  String p0;

  factory FParam3.fromJson(Map<String, dynamic> json) => _$FParam3FromJson(json);

  Map<String, dynamic> toJson() => _$FParam3ToJson(this);
}
@JsonSerializable()
class FRet4 {
  FRet4(this.ret);

  int ret;

  factory FRet4.fromJson(Map<String, dynamic> json) => _$FRet4FromJson(json);

  Map<String, dynamic> toJson() => _$FRet4ToJson(this);
}

