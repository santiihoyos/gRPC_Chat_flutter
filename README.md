# gRPC+ProtocolBuffers Chat by Flutter

gRPC Chat laboratory. It allows chat from each supported flutter platform: **Linux, macOS, Windows, Android, iOS and Web** by using gRPC and ProtocolBuffers also backend grpc microservice is written in Dart Lang. Generated Dart model files are shared with flutter app and micro-service from `model` package. 

#### Native implementations
There are 2 native(Kotlin and Swift) alternatives to flutter Android and iOS builds:

[gRPC_Chat_android](https://github.com/santiihoyos/gRPC_Chat_android)

[gRPC_Chat_iOS](https://github.com/NSCabezon/gRPCChat)

### Running dart microservice
```shell
cd server
dart pub get                          #use -upgrade- instead to run with latest dependencies version.  
dart run bin/main.dart localhost 8888 #Runs on localhost:8888
```

### Run Flutter app
```shell
flutter pub get  #use -upgrade- instead to run with latest dependencies version.
flutter run      #It will ask you for platform choise.
```

### Run Envoy L7 proxy to support gRPC on Web

To support gRPC on web we use Envoy proxy. It "convert/translate" gRPC calls to web-http2 calls from XHR.
Note that it is only necessary for web.

`FlutterWebApp` --port_9000--> `envoy proxy` --port_8888--> `gRPC service`

`FlutterNoWebApp` --port_8888--> `gRPC service`

#### Installing on macOS.
```shell
brew update
brew install envoy
```
> Note: To install it on another SO [see offcial doc about it](https://www.envoyproxy.io/docs/envoy/latest/start/install#)

#### Running
```shell
#Edit that yaml file if you use different port (default: 8888).
envoy --config-path server/setup/envoy/service_envoy.yaml
```

## Developing

### Generate Dart code from proto files

[Installation guide](https://grpc.io/docs/languages/dart/quickstart)

```shell
protoc -I. --dart_out=grpc:model/lib/data/generated/protos/ model/protos/chat.proto
```

