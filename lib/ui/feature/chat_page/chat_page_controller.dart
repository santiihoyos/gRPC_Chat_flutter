import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

String _gRpcServerHost = "localhost";
const int _gRpcWebServerPort = 9090;
const int _gRpcServerPort = 8890;

class ChatPageController extends GetxController {
  /// Reactive [List] of [Message] with room messages from server.
  final messages = List<Message>.empty().obs;

  /// Chat service client.
  late ChatClient _chatClient;

  /// Indentity object to call Chat service.
  late Rx<User> user;

  /// initializes chat service client and starts to listen messassages after
  /// test connection and greets to server.
  Future<void> initChat(String alias) async {
    try {
      final channel = GrpcOrGrpcWebClientChannel.toSeparateEndpoints(
        grpcHost: _gRpcServerHost,
        grpcPort: _gRpcServerPort,
        grpcWebHost: _gRpcServerHost,
        grpcWebPort: _gRpcWebServerPort,
        grpcWebTransportSecure: true,
        grpcTransportSecure: true,
      );

      /// Test connection to server
      final connection = await channel.getConnection();
      debugPrint("Connection: $connection");

      _chatClient = ChatClient(
        channel,
        options: CallOptions(
          timeout: const Duration(hours: 3),
        ),
      );

      await _sayHelloToServer(alias);
      await _getHistoryMessages();
      await _listenChat();
    } catch (ex) {
      debugPrint("Error on ChatClient initilization with error: $ex");
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

  /// Greets to serve to get user id
  Future<void> _sayHelloToServer(String alias) async {
    final newUser = await _chatClient.hello(Hello(nickName: alias));
    user = newUser.obs;
  }

  /// Get from server existing messages on chat room.
  Future<void> _getHistoryMessages() async {
    final messagesHistory = await _chatClient.getHistory(user.value);
    messages.addAll(messagesHistory.messages);
  }

  /// Listens new incoming messages from service.
  Future<void> _listenChat() async {
    Stream<Message> incomingMessages = _chatClient.listen(
      user.value,
      options: CallOptions(
        timeout: const Duration(hours: 3),
      ),
    );
    incomingMessages.listen((newMessage) => messages.add(newMessage));
  }
}
