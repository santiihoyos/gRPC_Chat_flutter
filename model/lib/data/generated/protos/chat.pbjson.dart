///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use aCKDescriptor instead')
const ACK$json = const {
  '1': 'ACK',
  '2': const [
    const {'1': 'NOT_SENT', '2': 0},
    const {'1': 'SENT', '2': 1},
  ],
};

/// Descriptor for `ACK`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List aCKDescriptor = $convert.base64Decode('CgNBQ0sSDAoITk9UX1NFTlQQABIICgRTRU5UEAE=');
@$core.Deprecated('Use helloDescriptor instead')
const Hello$json = const {
  '1': 'Hello',
  '2': const [
    const {'1': 'nickName', '3': 1, '4': 1, '5': 9, '10': 'nickName'},
  ],
};

/// Descriptor for `Hello`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloDescriptor = $convert.base64Decode('CgVIZWxsbxIaCghuaWNrTmFtZRgBIAEoCVIIbmlja05hbWU=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'nickName', '3': 2, '4': 1, '5': 9, '10': 'nickName'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgFUgJpZBIaCghuaWNrTmFtZRgCIAEoCVIIbmlja05hbWU=');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.com.santiihoyos.grpcchat.data.grpc.model.grpcchat.User', '10': 'user'},
    const {'1': 'epochTime', '3': 2, '4': 1, '5': 3, '10': 'epochTime'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEksKBHVzZXIYASABKAsyNy5jb20uc2FudGlpaG95b3MuZ3JwY2NoYXQuZGF0YS5ncnBjLm1vZGVsLmdycGNjaGF0LlVzZXJSBHVzZXISHAoJZXBvY2hUaW1lGAIgASgDUgllcG9jaFRpbWUSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use messageResultDescriptor instead')
const MessageResult$json = const {
  '1': 'MessageResult',
  '2': const [
    const {'1': 'ack', '3': 1, '4': 1, '5': 14, '6': '.com.santiihoyos.grpcchat.data.grpc.model.grpcchat.ACK', '10': 'ack'},
  ],
};

/// Descriptor for `MessageResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageResultDescriptor = $convert.base64Decode('Cg1NZXNzYWdlUmVzdWx0EkgKA2FjaxgBIAEoDjI2LmNvbS5zYW50aWlob3lvcy5ncnBjY2hhdC5kYXRhLmdycGMubW9kZWwuZ3JwY2NoYXQuQUNLUgNhY2s=');
@$core.Deprecated('Use historyDescriptor instead')
const History$json = const {
  '1': 'History',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.com.santiihoyos.grpcchat.data.grpc.model.grpcchat.Message', '10': 'messages'},
  ],
};

/// Descriptor for `History`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyDescriptor = $convert.base64Decode('CgdIaXN0b3J5ElYKCG1lc3NhZ2VzGAEgAygLMjouY29tLnNhbnRpaWhveW9zLmdycGNjaGF0LmRhdGEuZ3JwYy5tb2RlbC5ncnBjY2hhdC5NZXNzYWdlUghtZXNzYWdlcw==');
@$core.Deprecated('Use writeMessageDescriptor instead')
const WriteMessage$json = const {
  '1': 'WriteMessage',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WriteMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeMessageDescriptor = $convert.base64Decode('CgxXcml0ZU1lc3NhZ2USFgoGdXNlcklkGAEgASgFUgZ1c2VySWQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
