import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

/// Chat Service implementation
class ChatService extends ChatServiceBase {
  /// Messages list.
  final List<Message> _messagesHistory = [];

  /// Messages StreamController to broadcast incomming messages on [_messages].
  final StreamController<Message> _streamController =
      StreamController.broadcast();

  /// Public Stream<Message> to listen from clients incommign messages.
  late Stream<Message> _messages;

  ChatService() {
    _messages = _streamController.stream;
  }

  /// RPC called by clients to subscribe to incomming messages
  /// [call] Call context
  /// [request] Incomming object from remote caller of type [HandShake].
  @override
  Stream<Message> listen(call, HandShake request) {
    print(
      "[INFO] user with userID=${request.userId} and nick=${request.nick} connected",
    );
    return _messages;
  }

  /// RPC called by clients when they send any message to server.
  /// [call] Call context
  /// [request] Incomming object from remote caller of type [HandShake].
  /// returns [MessageResult] with ACK status of write operation.
  @override
  Future<MessageResult> write(call, Message request) {
    print("[INFO] user with userID=${request.userId} sent a message");
    _messagesHistory.add(request);
    _streamController.add(request);
    return Future.value(MessageResult(wasOK: true));
  }

  @override
  Future<History> getHistory(ServiceCall call, HandShake request) {
    return Future.sync(() => History(messages: _messagesHistory));
  }
}
