#!/bin/sh

# Generate protos
echo "Generating protos..."
protoc -I=. --dart_out=grpc:../lib/data/generated/protos "chat.proto"