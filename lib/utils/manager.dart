import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {
  final String baseURL;
  WebSocketChannel? webSocketChannel;

  int kills = 0;
  int deaths = 0;

  SocketManager(this.baseURL) {
    connect();
  }

  void handleMessage(message) async {
    switch (message) {
      case "kill:":
        kills++;
      case "dead:":
        deaths++;
    }
  }

  void connect() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse("ws://$baseURL"));

    webSocketChannel?.stream.listen(handleMessage);
  }
}
