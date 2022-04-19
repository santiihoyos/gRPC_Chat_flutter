import 'dart:async';
import 'dart:math';
import 'package:grpc/grpc.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';

/// Chat Service implementation
class ChatService extends ChatServiceBase {
  /// Messages list.
  final List<Message> _messagesHistory = [];

  /// Users list
  final List<User> _usersList = [];

  /// Messages StreamController to broadcast incomming messages on [_messages].
  final StreamController<Message> _streamController =
      StreamController.broadcast();

  /// Public Stream<Message> to listen from clients incommign messages.
  late Stream<Message> _messages;

  ChatService() {
    _messages = _streamController.stream;
  }

  /// Creation of new user on room when he says hello!
  @override
  Future<User> hello(ServiceCall call, Hello request) {
    final newUser = User(
      id: _usersList.length +
          Random(
            DateTime.now().microsecondsSinceEpoch,
          ).nextInt(10000),
      nickName: request.nickName,
    );
    _usersList.add(newUser);
    return Future.value(newUser);
  }

  /// RPC called by clients to subscribe to incomming messages
  /// [call] Call context
  /// [request] Incomming object from remote caller of type [HandShake].
  @override
  Stream<Message> listen(call, User request) {
    print(
      "[INFO] user with ID=${request.id} "
      "and nickName=${request.nickName} is listennig now.",
    );
    if (_usersList.where((usr) => usr.id == request.id).isEmpty) {
      return Stream.error("First say hello! >.<");
    }
    return _messages;
  }

  /// RPC called by clients when they send any message to server.
  /// [call] Call context
  /// [request] Incomming object from remote caller of type [WriteMessage].
  /// returns [MessageResult] with ACK status of write operation.
  @override
  Future<MessageResult> write(call, WriteMessage request) {
    print("[INFO] user with ID=${request.userId} sent a message.");
    final found = _usersList.where((usr) => usr.id == request.userId);
    if (found.isEmpty) {
      return Future.error(MessageResult(ack: ACK.NOT_SENT));
    }
    final newMessage = Message(
      user: found.first,
      message: request.message,
    );
    _messagesHistory.add(newMessage);
    _streamController.add(newMessage);
    return Future.value(MessageResult(
      ack: ACK.SENT,
    ));
  }

  /// Resturns current chat messages history.
  @override
  Future<History> getHistory(ServiceCall call, User request) {
    if (_usersList.where((usr) => usr.id == request.id).isEmpty) {
      return Future.error("First say hello! >.<");
    }
    print(
      "[INFO] user with ID=${request.id}"
      "and nickName=${request.nickName} got the history.",
    );
    return Future.sync(() => History(messages: _messagesHistory));
  }
}
