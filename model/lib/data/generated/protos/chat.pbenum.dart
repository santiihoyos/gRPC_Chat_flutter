///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ACK extends $pb.ProtobufEnum {
  static const ACK NOT_SENT = ACK._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_SENT');
  static const ACK SENT = ACK._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENT');

  static const $core.List<ACK> values = <ACK> [
    NOT_SENT,
    SENT,
  ];

  static final $core.Map<$core.int, ACK> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ACK? valueOf($core.int value) => _byValue[value];

  const ACK._($core.int v, $core.String n) : super(v, n);
}

