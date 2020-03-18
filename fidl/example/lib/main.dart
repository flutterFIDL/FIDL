import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean/AUser.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean/User.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean/UserInfo.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example/IChatService.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example/IUserService.dart';
import 'package:fidl_example/shape_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:fidl/fidl.dart';

import 'chat_screen.dart';
import 'fidl/com.infiniteloop.fidl_example.bean/MessageStatus.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  ChannelConnection _channelConnection;
  ChannelConnection _chatConnection;

  @override
  void initState() {
    super.initState();
    _channelConnection = ChannelConnection(() {
      print('onConnected');
    }, () {
      print('onDisconnected');
    });
    _chatConnection = ChannelConnection(() {
      print('chatService onConnected');
    }, () {
      print('chatService onDisconnected');
    });
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    Fidl.unbindChannel(IChatService.CHANNEL_NAME, _channelConnection);
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Fidl.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    bool success =
        await Fidl.bindChannel(IUserService.CHANNEL_NAME, _channelConnection);
    if (!success) {
      return;
    }

    String ret = await IUserService.initEnum1(MessageStatus.Readed);
    print('init result is $ret');

    Set<String> set = Set();
    set.add("value0");
    set.add("value1");
    set.add("value2");
    await IUserService.initList0(set.toList());
    await IUserService.initSet2(set);

    UserInfo info = UserInfo();
    info.age = 16;
    await IUserService.initObj0(info);

    AUser aUser = AUser();
    aUser.country = 'China';
    aUser.age = 16;
    await IUserService.initObj2(aUser);

    User<String> user = User();
    user.age = 16;
    await IUserService.initObj3(user);

    await Fidl.unbindChannel(IUserService.CHANNEL_NAME, _channelConnection);

    await Fidl.bindChannel(IChatService.CHANNEL_NAME, _chatConnection);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Running on: $_platformVersion\n'),
                ShapeButton(
                    onPressed: () async {
                      if (_chatConnection.connected) {
                        User<String> mySelf = User();
                        mySelf.age = 16;
                        mySelf.country = 'China';
                        mySelf.name = 'Oscar';
                        mySelf.uid = '1';
                        await IChatService.init(mySelf);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      } else {
                        var dialog = AlertDialog(
                            title: Text('Warning!'),
                            content: Text('Chat service is not connected!'),
                            actions: <Widget>[
                              FlatButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  })
                            ]);
                        showDialog<bool>(
                            context: context, builder: (_) => dialog);
                      }
                    },
                    child:
                        Text("Start chatting", style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
