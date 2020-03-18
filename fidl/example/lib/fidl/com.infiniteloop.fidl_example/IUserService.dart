import 'dart:async';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fidl/fidl.dart';
import "../com.infiniteloop.fidl_example.bean/EmptyEnum.dart";
import "../com.infiniteloop.fidl_example.bean/MessageStatus.dart";
import "../com.infiniteloop.fidl_example.bean/UserInfo.dart";
import "../com.infiniteloop.fidl_example.bean/User.dart";
import "../com.infiniteloop.fidl_example.bean/AUser.dart";
import "../com.infiniteloop.fidl_example.bean/Gender.dart";
import "../com.infiniteloop.fidl_example.bean/Conversation.dart";

part 'IUserService.g.dart';

class IUserService {
  static const String CHANNEL_NAME = 'com.infiniteloop.fidl_example.IUserService';
  static const MethodChannel _channel =
      const MethodChannel(CHANNEL_NAME, const MultiMethodCodec());

  static Future<void> initArr0(List<int> ids) async {
    var p0 = FParam0(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initArr0', param);
  }
  static Future<void> initArr1(List<List<int>> ids) async {
    var p0 = FParam1(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initArr1', param);
  }
  static Future<void> initEnum0(EmptyEnum e) async {
    var p0 = FParam2(e).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initEnum0', param);
  }
  static Future<String> initEnum1(MessageStatus status) async {
    var p0 = FParam3(status).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initEnum1', param);
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet3.fromJson(json).ret;
  }
  static Future<void> initList0(List<String> ids) async {
    var p0 = FParam4(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList0', param);
  }
  static Future<void> initList1(List<String> ids) async {
    var p0 = FParam5(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList1', param);
  }
  static Future<void> initList2(List<String> ids) async {
    var p0 = FParam6(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList2', param);
  }
  static Future<void> initList3(List<String> ids) async {
    var p0 = FParam7(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList3', param);
  }
  static Future<void> initList4(List<String> ids) async {
    var p0 = FParam8(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList4', param);
  }
  static Future<void> initList5(List<String> ids) async {
    var p0 = FParam9(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList5', param);
  }
  static Future<void> initList6(List<String> ids) async {
    var p0 = FParam10(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList6', param);
  }
  static Future<void> initList7(List<String> ids) async {
    var p0 = FParam11(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList7', param);
  }
  static Future<void> initList8(List<Object> ids) async {
    var p0 = FParam12(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList8', param);
  }
  static Future<void> initList9(List<String> ids) async {
    var p0 = FParam13(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList9', param);
  }
  static Future<void> initList10(List<Object> ids) async {
    var p0 = FParam14(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initList10', param);
  }
  static Future<void> initSet0(Set<Object> ids) async {
    var p0 = FParam15(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initSet0', param);
  }
  static Future<void> initSet1(Set<Object> ids) async {
    var p0 = FParam16(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initSet1', param);
  }
  static Future<void> initSet2(Set<String> ids) async {
    var p0 = FParam17(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initSet2', param);
  }
  static Future<void> initSet3(Set<Object> ids) async {
    var p0 = FParam18(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initSet3', param);
  }
  static Future<void> initSet4(Set<String> ids) async {
    var p0 = FParam19(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initSet4', param);
  }
  static Future<void> initSet5(Set<String> ids) async {
    var p0 = FParam20(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initSet5', param);
  }
  static Future<void> initMap0(Map<String,String> ids) async {
    var p0 = FParam21(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap0', param);
  }
  static Future<void> initMap1(Map map) async {
    var p0 = FParam22(map).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap1', param);
  }
  static Future<void> initMap2(Map<Object,String> map) async {
    var p0 = FParam23(map).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap2', param);
  }
  static Future<void> initMap3(Map<Object,Object> map) async {
    var p0 = FParam24(map).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap3', param);
  }
  static Future<void> initMap4(Map<Object,Object> map) async {
    var p0 = FParam25(map).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap4', param);
  }
  static Future<void> initMap5(Map<Object,List<Map<String,String>>> map) async {
    var p0 = FParam26(map).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap5', param);
  }
  static Future<void> initMap6(Map<String,String> ids) async {
    var p0 = FParam27(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap6', param);
  }
  static Future<void> initMap7(Map<String,String> ids) async {
    var p0 = FParam28(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap7', param);
  }
  static Future<void> initMap8(Map ids) async {
    var p0 = FParam29(ids).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initMap8', param);
  }
  static Future<void> initObj0(UserInfo info) async {
    var p0 = FParam30(info).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initObj0', param);
  }
  static Future<void> initObj1(User user) async {
    var p0 = FParam31(user).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initObj1', param);
  }
  static Future<void> initObj2(AUser user) async {
    var p0 = FParam32(user).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initObj2', param);
  }
  static Future<void> initObj3(User<String> user) async {
    var p0 = FParam33(user).toJson()['p0'];
    var param = Fidl.objectCodec.encode([p0]);
    var ret = await _channel.invokeMethod('initObj3', param);
  }
  static Future<String> initRet0() async {
    var ret = await _channel.invokeMethod('initRet0');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet34.fromJson(json).ret;
  }
  static Future<bool> initRet1() async {
    var ret = await _channel.invokeMethod('initRet1');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet35.fromJson(json).ret;
  }
  static Future<int> initRet2() async {
    var ret = await _channel.invokeMethod('initRet2');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet36.fromJson(json).ret;
  }
  static Future<int> initRet3() async {
    var ret = await _channel.invokeMethod('initRet3');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet37.fromJson(json).ret;
  }
  static Future<int> initRet4() async {
    var ret = await _channel.invokeMethod('initRet4');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet38.fromJson(json).ret;
  }
  static Future<int> initRet5() async {
    var ret = await _channel.invokeMethod('initRet5');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet39.fromJson(json).ret;
  }
  static Future<int> initRet6() async {
    var ret = await _channel.invokeMethod('initRet6');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet40.fromJson(json).ret;
  }
  static Future<bool> initRet7() async {
    var ret = await _channel.invokeMethod('initRet7');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet41.fromJson(json).ret;
  }
  static Future<List<bool>> initRet8() async {
    var ret = await _channel.invokeMethod('initRet8');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet42.fromJson(json).ret;
  }
  static Future<int> initRet9() async {
    var ret = await _channel.invokeMethod('initRet9');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet43.fromJson(json).ret;
  }
  static Future<List<int>> initRet10() async {
    var ret = await _channel.invokeMethod('initRet10');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet44.fromJson(json).ret;
  }
  static Future<int> initRet11() async {
    var ret = await _channel.invokeMethod('initRet11');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet45.fromJson(json).ret;
  }
  static Future<List<int>> initRet12() async {
    var ret = await _channel.invokeMethod('initRet12');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet46.fromJson(json).ret;
  }
  static Future<int> initRet13() async {
    var ret = await _channel.invokeMethod('initRet13');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet47.fromJson(json).ret;
  }
  static Future<List<int>> initRet14() async {
    var ret = await _channel.invokeMethod('initRet14');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet48.fromJson(json).ret;
  }
  static Future<int> initRet15() async {
    var ret = await _channel.invokeMethod('initRet15');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet49.fromJson(json).ret;
  }
  static Future<List<int>> initRet16() async {
    var ret = await _channel.invokeMethod('initRet16');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet50.fromJson(json).ret;
  }
  static Future<List<String>> initRet17() async {
    var ret = await _channel.invokeMethod('initRet17');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet51.fromJson(json).ret;
  }
  static Future<List<String>> initRet18() async {
    var ret = await _channel.invokeMethod('initRet18');
    var json = Fidl.objectCodec.decode(ret[0]);
    return FRet52.fromJson(json).ret;
  }
  static Future<void> init(String name, int age, Gender gender, Conversation conversation) async {
    var p0 = FParam53(name, age, gender, conversation).toJson()['p0'];
    var p1 = FParam53(name, age, gender, conversation).toJson()['p1'];
    var p2 = FParam53(name, age, gender, conversation).toJson()['p2'];
    var p3 = FParam53(name, age, gender, conversation).toJson()['p3'];
    var param = Fidl.objectCodec.encode([p0, p1, p2, p3]);
    var ret = await _channel.invokeMethod('init', param);
  }

}

@JsonSerializable()
class FParam0 {
  FParam0(this.p0);

  List<int> p0;

  factory FParam0.fromJson(Map<String, dynamic> json) => _$FParam0FromJson(json);

  Map<String, dynamic> toJson() => _$FParam0ToJson(this);
}
@JsonSerializable()
class FParam1 {
  FParam1(this.p0);

  List<List<int>> p0;

  factory FParam1.fromJson(Map<String, dynamic> json) => _$FParam1FromJson(json);

  Map<String, dynamic> toJson() => _$FParam1ToJson(this);
}
@JsonSerializable()
class FParam2 {
  FParam2(this.p0);

  EmptyEnum p0;

  factory FParam2.fromJson(Map<String, dynamic> json) => _$FParam2FromJson(json);

  Map<String, dynamic> toJson() => _$FParam2ToJson(this);
}
@JsonSerializable()
class FRet3 {
  FRet3(this.ret);

  String ret;

  factory FRet3.fromJson(Map<String, dynamic> json) => _$FRet3FromJson(json);

  Map<String, dynamic> toJson() => _$FRet3ToJson(this);
}
@JsonSerializable()
class FParam3 {
  FParam3(this.p0);

  MessageStatus p0;

  factory FParam3.fromJson(Map<String, dynamic> json) => _$FParam3FromJson(json);

  Map<String, dynamic> toJson() => _$FParam3ToJson(this);
}
@JsonSerializable()
class FParam4 {
  FParam4(this.p0);

  List<String> p0;

  factory FParam4.fromJson(Map<String, dynamic> json) => _$FParam4FromJson(json);

  Map<String, dynamic> toJson() => _$FParam4ToJson(this);
}
@JsonSerializable()
class FParam5 {
  FParam5(this.p0);

  List<String> p0;

  factory FParam5.fromJson(Map<String, dynamic> json) => _$FParam5FromJson(json);

  Map<String, dynamic> toJson() => _$FParam5ToJson(this);
}
@JsonSerializable()
class FParam6 {
  FParam6(this.p0);

  List<String> p0;

  factory FParam6.fromJson(Map<String, dynamic> json) => _$FParam6FromJson(json);

  Map<String, dynamic> toJson() => _$FParam6ToJson(this);
}
@JsonSerializable()
class FParam7 {
  FParam7(this.p0);

  List<String> p0;

  factory FParam7.fromJson(Map<String, dynamic> json) => _$FParam7FromJson(json);

  Map<String, dynamic> toJson() => _$FParam7ToJson(this);
}
@JsonSerializable()
class FParam8 {
  FParam8(this.p0);

  List<String> p0;

  factory FParam8.fromJson(Map<String, dynamic> json) => _$FParam8FromJson(json);

  Map<String, dynamic> toJson() => _$FParam8ToJson(this);
}
@JsonSerializable()
class FParam9 {
  FParam9(this.p0);

  List<String> p0;

  factory FParam9.fromJson(Map<String, dynamic> json) => _$FParam9FromJson(json);

  Map<String, dynamic> toJson() => _$FParam9ToJson(this);
}
@JsonSerializable()
class FParam10 {
  FParam10(this.p0);

  List<String> p0;

  factory FParam10.fromJson(Map<String, dynamic> json) => _$FParam10FromJson(json);

  Map<String, dynamic> toJson() => _$FParam10ToJson(this);
}
@JsonSerializable()
class FParam11 {
  FParam11(this.p0);

  List<String> p0;

  factory FParam11.fromJson(Map<String, dynamic> json) => _$FParam11FromJson(json);

  Map<String, dynamic> toJson() => _$FParam11ToJson(this);
}
@JsonSerializable()
class FParam12 {
  FParam12(this.p0);

  List<Object> p0;

  factory FParam12.fromJson(Map<String, dynamic> json) => _$FParam12FromJson(json);

  Map<String, dynamic> toJson() => _$FParam12ToJson(this);
}
@JsonSerializable()
class FParam13 {
  FParam13(this.p0);

  List<String> p0;

  factory FParam13.fromJson(Map<String, dynamic> json) => _$FParam13FromJson(json);

  Map<String, dynamic> toJson() => _$FParam13ToJson(this);
}
@JsonSerializable()
class FParam14 {
  FParam14(this.p0);

  List<Object> p0;

  factory FParam14.fromJson(Map<String, dynamic> json) => _$FParam14FromJson(json);

  Map<String, dynamic> toJson() => _$FParam14ToJson(this);
}
@JsonSerializable()
class FParam15 {
  FParam15(this.p0);

  Set<Object> p0;

  factory FParam15.fromJson(Map<String, dynamic> json) => _$FParam15FromJson(json);

  Map<String, dynamic> toJson() => _$FParam15ToJson(this);
}
@JsonSerializable()
class FParam16 {
  FParam16(this.p0);

  Set<Object> p0;

  factory FParam16.fromJson(Map<String, dynamic> json) => _$FParam16FromJson(json);

  Map<String, dynamic> toJson() => _$FParam16ToJson(this);
}
@JsonSerializable()
class FParam17 {
  FParam17(this.p0);

  Set<String> p0;

  factory FParam17.fromJson(Map<String, dynamic> json) => _$FParam17FromJson(json);

  Map<String, dynamic> toJson() => _$FParam17ToJson(this);
}
@JsonSerializable()
class FParam18 {
  FParam18(this.p0);

  Set<Object> p0;

  factory FParam18.fromJson(Map<String, dynamic> json) => _$FParam18FromJson(json);

  Map<String, dynamic> toJson() => _$FParam18ToJson(this);
}
@JsonSerializable()
class FParam19 {
  FParam19(this.p0);

  Set<String> p0;

  factory FParam19.fromJson(Map<String, dynamic> json) => _$FParam19FromJson(json);

  Map<String, dynamic> toJson() => _$FParam19ToJson(this);
}
@JsonSerializable()
class FParam20 {
  FParam20(this.p0);

  Set<String> p0;

  factory FParam20.fromJson(Map<String, dynamic> json) => _$FParam20FromJson(json);

  Map<String, dynamic> toJson() => _$FParam20ToJson(this);
}
@JsonSerializable()
class FParam21 {
  FParam21(this.p0);

  Map<String,String> p0;

  factory FParam21.fromJson(Map<String, dynamic> json) => _$FParam21FromJson(json);

  Map<String, dynamic> toJson() => _$FParam21ToJson(this);
}
@JsonSerializable()
class FParam22 {
  FParam22(this.p0);

  Map p0;

  factory FParam22.fromJson(Map<String, dynamic> json) => _$FParam22FromJson(json);

  Map<String, dynamic> toJson() => _$FParam22ToJson(this);
}
@JsonSerializable()
class FParam23 {
  FParam23(this.p0);

  Map<Object,String> p0;

  factory FParam23.fromJson(Map<String, dynamic> json) => _$FParam23FromJson(json);

  Map<String, dynamic> toJson() => _$FParam23ToJson(this);
}
@JsonSerializable()
class FParam24 {
  FParam24(this.p0);

  Map<Object,Object> p0;

  factory FParam24.fromJson(Map<String, dynamic> json) => _$FParam24FromJson(json);

  Map<String, dynamic> toJson() => _$FParam24ToJson(this);
}
@JsonSerializable()
class FParam25 {
  FParam25(this.p0);

  Map<Object,Object> p0;

  factory FParam25.fromJson(Map<String, dynamic> json) => _$FParam25FromJson(json);

  Map<String, dynamic> toJson() => _$FParam25ToJson(this);
}
@JsonSerializable()
class FParam26 {
  FParam26(this.p0);

  Map<Object,List<Map<String,String>>> p0;

  factory FParam26.fromJson(Map<String, dynamic> json) => _$FParam26FromJson(json);

  Map<String, dynamic> toJson() => _$FParam26ToJson(this);
}
@JsonSerializable()
class FParam27 {
  FParam27(this.p0);

  Map<String,String> p0;

  factory FParam27.fromJson(Map<String, dynamic> json) => _$FParam27FromJson(json);

  Map<String, dynamic> toJson() => _$FParam27ToJson(this);
}
@JsonSerializable()
class FParam28 {
  FParam28(this.p0);

  Map<String,String> p0;

  factory FParam28.fromJson(Map<String, dynamic> json) => _$FParam28FromJson(json);

  Map<String, dynamic> toJson() => _$FParam28ToJson(this);
}
@JsonSerializable()
class FParam29 {
  FParam29(this.p0);

  Map p0;

  factory FParam29.fromJson(Map<String, dynamic> json) => _$FParam29FromJson(json);

  Map<String, dynamic> toJson() => _$FParam29ToJson(this);
}
@JsonSerializable()
class FParam30 {
  FParam30(this.p0);

  UserInfo p0;

  factory FParam30.fromJson(Map<String, dynamic> json) => _$FParam30FromJson(json);

  Map<String, dynamic> toJson() => _$FParam30ToJson(this);
}
@JsonSerializable()
class FParam31 {
  FParam31(this.p0);

  User p0;

  factory FParam31.fromJson(Map<String, dynamic> json) => _$FParam31FromJson(json);

  Map<String, dynamic> toJson() => _$FParam31ToJson(this);
}
@JsonSerializable()
class FParam32 {
  FParam32(this.p0);

  AUser p0;

  factory FParam32.fromJson(Map<String, dynamic> json) => _$FParam32FromJson(json);

  Map<String, dynamic> toJson() => _$FParam32ToJson(this);
}
@JsonSerializable()
class FParam33 {
  FParam33(this.p0);

  User<String> p0;

  factory FParam33.fromJson(Map<String, dynamic> json) => _$FParam33FromJson(json);

  Map<String, dynamic> toJson() => _$FParam33ToJson(this);
}
@JsonSerializable()
class FRet34 {
  FRet34(this.ret);

  String ret;

  factory FRet34.fromJson(Map<String, dynamic> json) => _$FRet34FromJson(json);

  Map<String, dynamic> toJson() => _$FRet34ToJson(this);
}
@JsonSerializable()
class FRet35 {
  FRet35(this.ret);

  bool ret;

  factory FRet35.fromJson(Map<String, dynamic> json) => _$FRet35FromJson(json);

  Map<String, dynamic> toJson() => _$FRet35ToJson(this);
}
@JsonSerializable()
class FRet36 {
  FRet36(this.ret);

  int ret;

  factory FRet36.fromJson(Map<String, dynamic> json) => _$FRet36FromJson(json);

  Map<String, dynamic> toJson() => _$FRet36ToJson(this);
}
@JsonSerializable()
class FRet37 {
  FRet37(this.ret);

  int ret;

  factory FRet37.fromJson(Map<String, dynamic> json) => _$FRet37FromJson(json);

  Map<String, dynamic> toJson() => _$FRet37ToJson(this);
}
@JsonSerializable()
class FRet38 {
  FRet38(this.ret);

  int ret;

  factory FRet38.fromJson(Map<String, dynamic> json) => _$FRet38FromJson(json);

  Map<String, dynamic> toJson() => _$FRet38ToJson(this);
}
@JsonSerializable()
class FRet39 {
  FRet39(this.ret);

  int ret;

  factory FRet39.fromJson(Map<String, dynamic> json) => _$FRet39FromJson(json);

  Map<String, dynamic> toJson() => _$FRet39ToJson(this);
}
@JsonSerializable()
class FRet40 {
  FRet40(this.ret);

  int ret;

  factory FRet40.fromJson(Map<String, dynamic> json) => _$FRet40FromJson(json);

  Map<String, dynamic> toJson() => _$FRet40ToJson(this);
}
@JsonSerializable()
class FRet41 {
  FRet41(this.ret);

  bool ret;

  factory FRet41.fromJson(Map<String, dynamic> json) => _$FRet41FromJson(json);

  Map<String, dynamic> toJson() => _$FRet41ToJson(this);
}
@JsonSerializable()
class FRet42 {
  FRet42(this.ret);

  List<bool> ret;

  factory FRet42.fromJson(Map<String, dynamic> json) => _$FRet42FromJson(json);

  Map<String, dynamic> toJson() => _$FRet42ToJson(this);
}
@JsonSerializable()
class FRet43 {
  FRet43(this.ret);

  int ret;

  factory FRet43.fromJson(Map<String, dynamic> json) => _$FRet43FromJson(json);

  Map<String, dynamic> toJson() => _$FRet43ToJson(this);
}
@JsonSerializable()
class FRet44 {
  FRet44(this.ret);

  List<int> ret;

  factory FRet44.fromJson(Map<String, dynamic> json) => _$FRet44FromJson(json);

  Map<String, dynamic> toJson() => _$FRet44ToJson(this);
}
@JsonSerializable()
class FRet45 {
  FRet45(this.ret);

  int ret;

  factory FRet45.fromJson(Map<String, dynamic> json) => _$FRet45FromJson(json);

  Map<String, dynamic> toJson() => _$FRet45ToJson(this);
}
@JsonSerializable()
class FRet46 {
  FRet46(this.ret);

  List<int> ret;

  factory FRet46.fromJson(Map<String, dynamic> json) => _$FRet46FromJson(json);

  Map<String, dynamic> toJson() => _$FRet46ToJson(this);
}
@JsonSerializable()
class FRet47 {
  FRet47(this.ret);

  int ret;

  factory FRet47.fromJson(Map<String, dynamic> json) => _$FRet47FromJson(json);

  Map<String, dynamic> toJson() => _$FRet47ToJson(this);
}
@JsonSerializable()
class FRet48 {
  FRet48(this.ret);

  List<int> ret;

  factory FRet48.fromJson(Map<String, dynamic> json) => _$FRet48FromJson(json);

  Map<String, dynamic> toJson() => _$FRet48ToJson(this);
}
@JsonSerializable()
class FRet49 {
  FRet49(this.ret);

  int ret;

  factory FRet49.fromJson(Map<String, dynamic> json) => _$FRet49FromJson(json);

  Map<String, dynamic> toJson() => _$FRet49ToJson(this);
}
@JsonSerializable()
class FRet50 {
  FRet50(this.ret);

  List<int> ret;

  factory FRet50.fromJson(Map<String, dynamic> json) => _$FRet50FromJson(json);

  Map<String, dynamic> toJson() => _$FRet50ToJson(this);
}
@JsonSerializable()
class FRet51 {
  FRet51(this.ret);

  List<String> ret;

  factory FRet51.fromJson(Map<String, dynamic> json) => _$FRet51FromJson(json);

  Map<String, dynamic> toJson() => _$FRet51ToJson(this);
}
@JsonSerializable()
class FRet52 {
  FRet52(this.ret);

  List<String> ret;

  factory FRet52.fromJson(Map<String, dynamic> json) => _$FRet52FromJson(json);

  Map<String, dynamic> toJson() => _$FRet52ToJson(this);
}
@JsonSerializable()
class FParam53 {
  FParam53(this.p0, this.p1, this.p2, this.p3);

  String p0;
  int p1;
  Gender p2;
  Conversation p3;

  factory FParam53.fromJson(Map<String, dynamic> json) => _$FParam53FromJson(json);

  Map<String, dynamic> toJson() => _$FParam53ToJson(this);
}

