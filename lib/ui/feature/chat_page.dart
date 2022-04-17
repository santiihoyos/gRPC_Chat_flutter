import 'dart:math';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:grpc_chat_flutter/ui/theme/theme.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

const String gRpcServerHost = "vps-7fe29e2f.vps.ovh.net";
const int gRpcWebServerPort = 9000;
const int gRpcServerPort = 8888;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late int userId;
  late ChatClient _chatClient;
  List<Message> _messages = [];

  final ScrollController _scrollController = ScrollController();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Santander Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[700],
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    child: Text(
                      _messages[(_messages.length - 1) - index].message,
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
                      onFieldSubmitted: (text) {
                        _sendMeesage(text);
                        _textEditingController.clear();
                      },
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        height: 60,
                        color: Colors.indigoAccent,
                        child: Text(
                          getAppLocalizationsOf(context).send_button_text,
                          style: const TextStyle(
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
      final channel = GrpcOrGrpcWebClientChannel.toSeparateEndpoints(
        grpcHost: gRpcServerHost,
        grpcPort: gRpcServerPort,
        grpcWebHost: gRpcServerHost,
        grpcWebPort: gRpcWebServerPort,
        grpcWebTransportSecure: false,
        grpcTransportSecure: false,
      );

      _chatClient = ChatClient(channel);

      userId = Random(
        DateTime.now().microsecondsSinceEpoch,
      ).nextInt(999999).toInt();

      debugPrint("ChatClient created!");
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
      _scrollToLast();
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    _chatClient.listen(handShakeMessage).listen((newMessage) {
      debugPrint("New incoming message!");
      setState(
        () {
          _messages.add(newMessage);
        },
      );
      _scrollToLast();
    });
  }

  void _scrollToLast() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.bounceIn,
    );
  }
}
