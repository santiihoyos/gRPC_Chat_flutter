import 'package:grpc_chat_flutter/di/injector.dart';
import 'package:get/get.dart';

class Pager {
  late List<GetPage> pages;

  Pager({
    required final Injector injector,
  }) {
    pages = [
      GetPage(
        name: "/",
        page: injector.getChatPage,
      ),
    ];
  }
}
