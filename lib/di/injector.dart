import 'package:grpc_chat_flutter/base/service/implementation/url_service_common.dart';
import 'package:grpc_chat_flutter/base/service/url_service.dart';
import 'package:get/get.dart';

class Injector {
  ///Creates or find Instance of [Injector]
  static Injector getInstance() {
    late Injector injector;
    try {
      injector = Get.find();
    } catch (ex) {
      injector = Injector();
    } finally {
      // ignore: control_flow_in_finally
      return injector;
    }
  }

  Injector() {
    Get.put(this);
  }

  T find<T>({String? tag}) {
    return Get.find(tag: tag);
  }

  /// resolves a instance of [UrlService]
  static UrlService getUrlService() {
    return Get.put(UrlServiceCommonImpl());
  }

//endregion
}
