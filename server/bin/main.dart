import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

const serverUrl = "localhost";
const serverPort = 7890;

///EntryPoint of Barber book backend
void main(List<String> arguments) async {
  final router = Router();
  var server = await shelf_io.serve(router, serverUrl, serverPort)
    ..autoCompress = true
    ..sessionTimeout = Duration(seconds: 30).inMilliseconds;

  print("Server serving at ${server.address.host}:${server.port}");
}
