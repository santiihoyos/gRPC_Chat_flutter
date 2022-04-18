import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

const String _gRpcServerHost = "vps-7fe29e2f.vps.ovh.net";
const int _gRpcWebServerPort = 9000;
const int _gRpcServerPort = 8888;

class ChatPageController extends GetxController {
  /// Reactive [List] of [Message] with room messages from server.
  final messages = List<Message>.empty().obs;

  /// Calculated user id.
  late int userId;

  /// Chat service client.
  late ChatClient _chatClient;

  /// Indentity object to call Chat service.
  late HandShake _handShake;

  ChatPageController() {
    userId = Random(
      DateTime.now().microsecondsSinceEpoch,
    ).nextInt(999999).toInt();
    _handShake = HandShake(userId: userId, nick: "flutter");
    _initChat();
  }

  /// sends [message] to server service and
  /// returns - [bool] with call result.
  Future<bool> sendMeesage(String message) async {
    final result = await _chatClient.write(
      Message(
        userId: userId,
        message: message,
        dateTime: Int64(DateTime.now().millisecondsSinceEpoch),
      ),
    );
    return Future.value(result.wasOK);
  }

  /// initialize chat service client and starts to listen messassages.
  Future<void> _initChat() async {
    try {
      final channel = GrpcOrGrpcWebClientChannel.toSeparateEndpoints(
        grpcHost: _gRpcServerHost,
        grpcPort: _gRpcServerPort,
        grpcWebHost: _gRpcServerHost,
        grpcWebPort: _gRpcWebServerPort,
        grpcWebTransportSecure: false,
        grpcTransportSecure: false,
      );
      _chatClient = ChatClient(channel);
      _getHistoryMessages();
      _listenChat();
    } catch (ex) {
      debugPrint("Error on ChatClient creation. $ex");
    }
  }

  /// Get from server existing messages on chat room.
  void _getHistoryMessages() async {
    final messagesHistory = await _chatClient.getHistory(_handShake);
    messages.addAll(messagesHistory.messages);
  }

  /// Listens new incoming messages from service.
  void _listenChat() async {
    Stream<Message> incomingMessages = _chatClient.listen(_handShake);
    incomingMessages.listen((newMessage) => messages.add(newMessage));
  }
}
