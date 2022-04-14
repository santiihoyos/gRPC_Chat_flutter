#!/bin/sh

# Generate protos
echo "Generating protos..."
protoc -I=. --dart_out=grpc:./lib/generated  "protos/chat.proto"