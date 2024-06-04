import 'package:flutter/cupertino.dart';

class GameDataProvider extends ChangeNotifier {

  int _kills = 0;
  int _deaths = 0;

  GameDataProvider();

  int get deaths => _deaths;

  set deaths(int value) {
    _deaths = value;
  }

  int get kills => _kills;

  set kills(int value) {
    _kills = value;
  }
}
