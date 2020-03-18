import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean.Conversation/ConversationType.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean/Conversation.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean/MessageDirection.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example.bean/UiMessage.dart';
import 'package:fidl_example/fidl/com.infiniteloop.fidl_example/IConversationService.dart';
import 'package:fidl_example/shape_button.dart';
import 'package:flutter/material.dart';
import 'package:fidl/fidl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChannelConnection _conversationConnection;
  Conversation _conversation;
  String partnerName = 'Amy';

  @override
  void initState() {
    super.initState();
    _conversationConnection = ChannelConnection(() {
      print('Conversation Service onConnected');
    }, () {
      print('Conversation Service onDisconnected');
    });

    _conversation = Conversation();
    _conversation.target = '0';
    _conversation.type = ConversationType.Single;

    initConversationService();
  }

  Future<void> initConversationService() async {
    await Fidl.bindChannel(
        IConversationService.CHANNEL_NAME, _conversationConnection);
  }

  @override
  void dispose() {
    super.dispose();
    Fidl.unbindChannel(
        IConversationService.CHANNEL_NAME, _conversationConnection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Chat'),
      ),
      body: Builder(
        builder: (context) => Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose someone to chat'),
            SizedBox(height: 4),
            ShapeButton(
                onPressed: () async {
                  setState(() {
                    partnerName = 'Amy';
                  });
                  await showConversationDesc('10');
                },
                child: Text('Chat with Amy')),
            ShapeButton(
                onPressed: () async {
                  setState(() {
                    partnerName = 'Wilson';
                  });
                  await showConversationDesc('11');
                },
                child: Text('Chat with Wilson')),
            ShapeButton(
                onPressed: () async {
                  setState(() {
                    partnerName = 'Lucy';
                  });
                  await showConversationDesc('12');
                },
                child: Text('Chat with Lucy')),
            SizedBox(height: 20),
            Text('Click the buttons below one by one'),
            SizedBox(height: 4),
            ShapeButton(
                onPressed: () async {
                  List<UiMessage> messages =
                      await IConversationService.getMessages();
                  print(messages.length);
                  print(messages);

                  List<Widget> widgets = [];
                  messages.forEach((uiMessage) {
                    if (uiMessage.message.direction == MessageDirection.Send) {
                      widgets.add(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                              'Oscar: ${uiMessage.message.content.extra}')));
                    } else {
                      widgets.add(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                              '$partnerName: ${uiMessage.message.content.extra}')));
                    }
                  });

                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                              title: Text(
                                  'Messages with $partnerName'),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: widgets,
                              )),
                              actions: <Widget>[
                                FlatButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    })
                              ]));
                },
                child: Text('Get history messages')),
            ShapeButton(
                onPressed: () async {
                  await IConversationService.sendMessage('Hello from flutter!');
                  Fluttertoast.showToast(msg: 'Done!');
                },
                child: Text('Send a message')),
            ShapeButton(
                onPressed: () async {
                  int count = await IConversationService.getMessageCount();
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                              title: Text('Message count is:'),
                              content: Text('$count'),
                              actions: <Widget>[
                                FlatButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    })
                              ]));
                },
                child: Text('Get the number of messages'))
          ],
        )),
      ),
    );
  }

  Future<void> showConversationDesc(String targetUid) async {
    Conversation conversation = Conversation();
    conversation.target = targetUid;
    conversation.type = ConversationType.Single;
    setState(() {
      _conversation = conversation;
    });

    await IConversationService.setupConversation(conversation);
    String conversationDesc = await IConversationService.getConversationDesc();
    showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
                title: Text('Conversation Description'),
                content: Text(conversationDesc),
                actions: <Widget>[
                  FlatButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      })
                ]));
  }
}
