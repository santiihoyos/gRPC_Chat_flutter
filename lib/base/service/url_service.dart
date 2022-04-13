import 'package:flutter_poc/base/service/base_service.dart';
import 'package:flutter/material.dart';

abstract class UrlService extends BaseService {
  /// Opens a url in new browser screen or web view.
  Future<bool> openUrl(String urlString,
      {bool? forceSafariVC,
      bool forceWebView = false,
      bool enableJavaScript = false,
      bool enableDomStorage = false,
      bool universalLinksOnly = false,
      Map<String, String> headers = const <String, String>{},
      Brightness? statusBarBrightness,
      String? webOnlyWindowName});
}
