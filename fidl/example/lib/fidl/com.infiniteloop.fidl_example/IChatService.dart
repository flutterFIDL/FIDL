import 'dart:async';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fidl/fidl.dart';
import "../com.infiniteloop.fidl_example.bean/User.dart";

part 'IChatService.g.dart';

class IChatService {
  static const String CHANNEL_NAME = 'com.infiniteloop.fidl_example.IChatService';
  static const MethodChannel _channel =
      const MethodChannel(CHANNEL_NAME, const MultiMethodCodec());

  static Future<bool> init(User<String> user) async {
    var p0 = FParam0(user).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('init', param);
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet0.fromJson(json).ret;
  }

}

@JsonSerializable()
class FRet0 {
  FRet0(this.ret);

  bool ret;

  factory FRet0.fromJson(Map<String, dynamic> json) => _$FRet0FromJson(json);

  Map<String, dynamic> toJson() => _$FRet0ToJson(this);
}
@JsonSerializable()
class FParam0 {
  FParam0(this.p0);

  User<String> p0;

  factory FParam0.fromJson(Map<String, dynamic> json) => _$FParam0FromJson(json);

  Map<String, dynamic> toJson() => _$FParam0ToJson(this);
}

