import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
export 'multi_message_codec.dart';
export 'type_util.dart';

class Fidl {
  static const MethodChannel _channel = const MethodChannel('fidl');
  static ObjectCodec objectCodec = JsonObjectCodec();

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> bindChannel(
      String channelName, ChannelConnection conn) async {
    // TODO conn 回调监听
    final bool success = await _channel
        .invokeMethod('bind', {'name': channelName, 'code': conn.hashCode});

    String name = '$channelName${conn.hashCode}';
    EventChannel(name).receiveBroadcastStream().listen((data) {
      if (data is bool) {
        conn.connected = data;
        if (data) {
          conn.onConnected();
        } else {
          conn.onDisconnected();
        }
      }
    });
    return success;
  }

  static Future<void> unbindChannel(
      String channelName, ChannelConnection conn) async {
    await _channel
        .invokeMethod('unbind', {'name': channelName, 'code': conn.hashCode});
  }
}

typedef void OnConnectedCallback();
typedef void OnDisconnectedCallback();

class ChannelConnection {
  bool connected = false;

  OnConnectedCallback onConnected;
  OnDisconnectedCallback onDisconnected;

  ChannelConnection(this.onConnected, this.onDisconnected);
}

abstract class ObjectCodec {
  dynamic decode(Uint8List input);

  List<Uint8List> encode(List objects);
}

class JsonObjectCodec extends ObjectCodec {
  @override
  decode(Uint8List input) {
    return jsonDecode(utf8.decode(input));
  }

  @override
  List<Uint8List> encode(List objects) {
    List<Uint8List> list = [];
    objects.forEach((object) {
      list.add(
          utf8.encoder.convert(jsonEncode(object, toEncodable: toEncodable)));
    });
    return list;
  }

  static Object toEncodable(Object nonEncodable) {
    try {
      return (nonEncodable as dynamic).toJson();
    } catch (ex) {}
    return 'unknown';
  }
}

class GenericConverter<T> implements JsonConverter<T, Object> {
  const GenericConverter();

  @override
  T fromJson(Object json) {
    return json;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
