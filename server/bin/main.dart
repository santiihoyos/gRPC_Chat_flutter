// ignore_for_file: avoid_relative_lib_imports

import 'dart:io';
import 'package:grpc/grpc.dart';
import 'package:model/data/generated/protos/chat.pbgrpc.dart';
import '../lib/services/grpc_chat_service.dart';

const int defaultPort = 8888;
const String defaultHost = "0.0.0.0";

/// Server entrypoint
/// arguments at index 0 will be host (default: 0.0.0.0)
/// arguments at index 1 will be port (default: 8888)
/// IMPORTANT: setup envoy proxy config file .yaml to match with host and port.
/// see: server/setup/envoy/service_emvoy.yaml
void main(List<String> arguments) async {
  var actualPort = defaultPort;
  var actualHost = defaultHost;

  if (arguments.isNotEmpty) {
    try {
      actualHost = arguments[0];
    } catch (ex) {
      print("[ERROR] expected String value at argument with index 0");
      exit(-1);
    }
  }

  if (arguments.length > 1) {
    try {
      actualPort = int.parse(arguments[1]);
    } catch (ex) {
      print("[ERROR] expected int value at argument with index 1");
      exit(-1);
    }
  }

  initChatService(host: actualHost, port: actualPort);
}

/// inits Chat services using [ChatService] implementation of [ChatServiceBase]
void initChatService({
  required String host,
  required int port,
}) async {
  final ChatService chatService = ChatService();
  final server = Server(
    [chatService],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec()]),
  );

  await server.serve(
    address: host,
    port: port,
  );

  print('[RUNNING] Chat service on $host:${server.port}');
}
