///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
export 'chat.pb.dart';

class ChatClient extends $grpc.Client {
  static final _$write = $grpc.ClientMethod<$0.Message, $0.MessageResult>(
      '/com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat/write',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MessageResult.fromBuffer(value));
  static final _$listen = $grpc.ClientMethod<$0.HandShake, $0.Message>(
      '/com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat/listen',
      ($0.HandShake value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.MessageResult> write($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$write, request, options: options);
  }

  $grpc.ResponseStream<$0.Message> listen($0.HandShake request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$listen, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name =>
      'com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $0.MessageResult>(
        'write',
        write_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.MessageResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HandShake, $0.Message>(
        'listen',
        listen_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HandShake.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$0.MessageResult> write_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return write(call, await request);
  }

  $async.Stream<$0.Message> listen_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HandShake> request) async* {
    yield* listen(call, await request);
  }

  $async.Future<$0.MessageResult> write(
      $grpc.ServiceCall call, $0.Message request);
  $async.Stream<$0.Message> listen(
      $grpc.ServiceCall call, $0.HandShake request);
}
