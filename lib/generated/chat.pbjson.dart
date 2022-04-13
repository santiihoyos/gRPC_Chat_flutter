///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use handShakeDescriptor instead')
const HandShake$json = const {
  '1': 'HandShake',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'nick', '3': 2, '4': 1, '5': 9, '10': 'nick'},
  ],
};

/// Descriptor for `HandShake`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handShakeDescriptor = $convert.base64Decode('CglIYW5kU2hha2USFgoGdXNlcklkGAEgASgFUgZ1c2VySWQSEgoEbmljaxgCIAEoCVIEbmljaw==');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'userId', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'dateTime', '3': 2, '4': 1, '5': 3, '10': 'dateTime'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEhYKBnVzZXJJZBgBIAEoBVIGdXNlcklkEhoKCGRhdGVUaW1lGAIgASgDUghkYXRlVGltZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use messageResultDescriptor instead')
const MessageResult$json = const {
  '1': 'MessageResult',
  '2': const [
    const {'1': 'wasOK', '3': 1, '4': 1, '5': 8, '10': 'wasOK'},
  ],
};

/// Descriptor for `MessageResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageResultDescriptor = $convert.base64Decode('Cg1NZXNzYWdlUmVzdWx0EhQKBXdhc09LGAEgASgIUgV3YXNPSw==');
