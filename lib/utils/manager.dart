import 'dart:math';

import 'package:conra_client/provider/gameDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {
  final String baseURL;
  WebSocketChannel? webSocketChannel;

  var context;

  SocketManager(this.baseURL, this.context) {
    connect();
  }

  void handleMessage(message) async {
    //todo does not update
    GameDataProvider gameDataProvider =
        Provider.of<GameDataProvider>(context, listen: false);

    print(message);

    switch (message) {
      case "kill:":
        {
          gameDataProvider.kills++;
          print(gameDataProvider.kills);
        }
      case "dead:":
        {
          gameDataProvider.deaths++;
          print(gameDataProvider.deaths);
        }
    }
  }

  void connect() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse("ws://$baseURL"));

    webSocketChannel?.stream.listen(handleMessage);
  }
}
