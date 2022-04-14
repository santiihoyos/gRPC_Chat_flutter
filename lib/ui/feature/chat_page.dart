import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import '../../generated/chat.pbgrpc.dart';

const String serverHost = "localhost";
const String androidServerHost = "10.0.2.2";
const int serverPort = 8888;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];

  late ChatClient _chatClient;
  late int userId;

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
      late ClientChannelBase channel;

      channel = ClientChannel(
        GetPlatform.isAndroid ? androidServerHost : serverHost,
        port: serverPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      _chatClient = ChatClient(
        channel,
        options: CallOptions(
          timeout: const Duration(seconds: 30),
        ),
      );

      userId = Random(DateTime.now().microsecondsSinceEpoch)
          .nextInt(99999999)
          .toInt();

      return Future.value(true);
    } catch (ex) {
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
    _chatClient
        .listen(handShakeMessage,
            options: CallOptions(
              timeout: const Duration(hours: 1),
            ))
        .listen((newMessage) {
      debugPrint("Nuevo mensaje!");
      setState(
        () {
          _messages.add(newMessage);
        },
      );
    });
  }
}
