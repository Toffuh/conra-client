import 'package:flutter/cupertino.dart';

class UrlProvider extends ChangeNotifier {
  String _url =
      "192.168.137.98:8765/";

  UrlProvider();

  String get url => _url;

  set url(String value) {
    _url = value;
  }
}
