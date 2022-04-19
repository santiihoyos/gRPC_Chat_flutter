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
  static final _$hello = $grpc.ClientMethod<$0.Hello, $0.User>(
      '/com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat/hello',
      ($0.Hello value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$getHistory = $grpc.ClientMethod<$0.User, $0.History>(
      '/com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat/getHistory',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.History.fromBuffer(value));
  static final _$write = $grpc.ClientMethod<$0.WriteMessage, $0.MessageResult>(
      '/com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat/write',
      ($0.WriteMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MessageResult.fromBuffer(value));
  static final _$listen = $grpc.ClientMethod<$0.User, $0.Message>(
      '/com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat/listen',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.User> hello($0.Hello request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hello, request, options: options);
  }

  $grpc.ResponseFuture<$0.History> getHistory($0.User request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.MessageResult> write($0.WriteMessage request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$write, request, options: options);
  }

  $grpc.ResponseStream<$0.Message> listen($0.User request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$listen, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name =>
      'com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Hello, $0.User>(
        'hello',
        hello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Hello.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.History>(
        'getHistory',
        getHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.History value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WriteMessage, $0.MessageResult>(
        'write',
        write_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WriteMessage.fromBuffer(value),
        ($0.MessageResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.Message>(
        'listen',
        listen_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> hello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Hello> request) async {
    return hello(call, await request);
  }

  $async.Future<$0.History> getHistory_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return getHistory(call, await request);
  }

  $async.Future<$0.MessageResult> write_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WriteMessage> request) async {
    return write(call, await request);
  }

  $async.Stream<$0.Message> listen_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async* {
    yield* listen(call, await request);
  }

  $async.Future<$0.User> hello($grpc.ServiceCall call, $0.Hello request);
  $async.Future<$0.History> getHistory($grpc.ServiceCall call, $0.User request);
  $async.Future<$0.MessageResult> write(
      $grpc.ServiceCall call, $0.WriteMessage request);
  $async.Stream<$0.Message> listen($grpc.ServiceCall call, $0.User request);
}
