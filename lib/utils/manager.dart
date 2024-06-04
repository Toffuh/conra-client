import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {
  final String baseURL;
  WebSocketChannel? webSocketChannel;

  SocketManager(this.baseURL) {
    connect();
  }

  void handleMessage(message) async {
    print(message);
  }

  void connect() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse("ws://$baseURL"));

    webSocketChannel?.stream.listen(handleMessage);
  }
}
