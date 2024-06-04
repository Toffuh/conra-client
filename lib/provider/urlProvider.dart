import 'package:flutter/cupertino.dart';

class UrlProvider extends ChangeNotifier {
  String _url =
      "localhost:8765/";

  UrlProvider();

  String get url => _url;

  set url(String value) {
    _url = value;
  }
}
