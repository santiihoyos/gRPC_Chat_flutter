import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

String _gRpcServerHost = GetPlatform.isAndroid ? "10.0.2.2" : "localhost";
const int _gRpcWebServerPort = 9000;
const int _gRpcServerPort = 8888;

class ChatPageController extends GetxController {
  /// Reactive [List] of [Message] with room messages from server.
  final messages = List<Message>.empty().obs;

  /// Chat service client.
  late ChatClient _chatClient;

  /// Indentity object to call Chat service.
  late Rx<User> user;

  /// initialize chat service client and starts to listen messassages.
  Future<void> initChat(String alias) async {
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
      final newUser = await _chatClient.hello(Hello(nickName: alias));
      user = newUser.obs;
      _getHistoryMessages();
      _listenChat();
    } catch (ex) {
      debugPrint("Error on ChatClient creation. $ex");
    }
  }

  /// sends [message] to server service and
  /// returns - [bool] with call result.
  Future<bool> sendMeesage(String message) async {
    final result = await _chatClient.write(
      WriteMessage(
        userId: user.value.id,
        message: message,
      ),
    );
    return Future.value(result.ack == ACK.SENT);
  }

  /// Get from server existing messages on chat room.
  void _getHistoryMessages() async {
    final messagesHistory = await _chatClient.getHistory(user.value);
    messages.addAll(messagesHistory.messages);
  }

  /// Listens new incoming messages from service.
  void _listenChat() async {
    Stream<Message> incomingMessages = _chatClient.listen(user.value);
    incomingMessages.listen((newMessage) => messages.add(newMessage));
  }
}
