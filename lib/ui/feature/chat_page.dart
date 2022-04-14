import 'dart:math';

import 'package:build_grpc_channel/build_grpc_channel.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:grpc/grpc_web.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

const String serverHost = "localhost";
const int serverPort = 9000;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late int userId;
  late ChatClient _chatClient;
  List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    ///Inits chat connection -> listen and send firs message after 3 seconds
    _initChat().then((initOk) {
      if (initOk) {
        debugPrint("Conectado OK!");
        _listenChat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        title: const Text(
          "Santander Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    child: Text(
                      _messages[index].message,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _textEditingController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        height: 60,
                        color: Colors.indigoAccent,
                        child: const Text(
                          "Send!",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _sendMeesage(_textEditingController.text);
                          _textEditingController.clear();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _initChat() async {
    try {
      final port = GetPlatform.isWeb ? 9000 : 8888;
      debugPrint("Conectando con: $serverHost:$serverPort");
      final channel = GrpcWebClientChannel.xhr(
        Uri.http("$serverHost:$port", "/"),
      );

      _chatClient = ChatClient(channel);

      userId =
          Random(DateTime.now().microsecondsSinceEpoch).nextInt(999999).toInt();

      debugPrint("ChatCliente created!");
      return Future.value(true);
    } catch (ex) {
      debugPrint("Error on ChatClient creation. $ex");
      return Future.value(false);
    }
  }

  void _sendMeesage(String message) {
    _chatClient.write(
      Message(
        userId: userId,
        message: message,
        dateTime: Int64(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  void _listenChat() {
    final handShakeMessage = HandShake(userId: userId, nick: "Santi");
    _chatClient.getHistory(handShakeMessage).then((history) {
      setState(() {
        _messages = history.messages;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    _chatClient.listen(handShakeMessage).listen((newMessage) {
      debugPrint("Nuevo mensaje!");
      setState(
        () {
          _messages.add(newMessage);
        },
      );
    });
  }
}
