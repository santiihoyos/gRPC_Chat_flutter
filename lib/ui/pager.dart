import 'package:flutter_poc/di/injector.dart';
import 'package:flutter_poc/ui/feature/chat_page.dart';
import 'package:get/get.dart';

class Pager {
  late List<GetPage> pages;

  Pager({
    required final Injector injector,
  }) {
    pages = [
      GetPage(
        name: "/",
        page: () => const ChatPage(),
      ),
    ];
  }
}
