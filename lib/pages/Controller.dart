import 'package:conra_client/provider/urlProvider.dart';
import 'package:conra_client/utils/manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  late SocketManager socketManager;

  @override
  void initState() {
    UrlProvider urlProvider = Provider.of<UrlProvider>(context, listen: false);

    socketManager = SocketManager(urlProvider.url);

    super.initState();
  }

  void handleLeftPress() {
    socketManager.webSocketChannel?.sink.add("direction:left");
  }

  void handleRightPress() {
    socketManager.webSocketChannel?.sink.add("direction:right");
  }

  void handleUpPress() {
    socketManager.webSocketChannel?.sink.add("jump:");
  }

  void handleNoPress() {
    socketManager.webSocketChannel?.sink.add("direction:stop");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Conra - Controller"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _showExitConfirmationDialog(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              left: 40,
              top: 40,
              child:
                  Text("Kills: ${socketManager.kills}", style: const TextStyle(fontSize: 20))),
          Positioned(
              left: 40,
              top: 60,
              child: Text("Deaths: ${socketManager.deaths}",
                  style: const TextStyle(fontSize: 20))),
          Positioned(
              left: 40,
              top: 80,
              child: socketManager.deaths == 0
                  ? Text("KD: ${socketManager.kills}", style: const TextStyle(fontSize: 20))
                  : Text("KD: ${socketManager.kills / socketManager.deaths}",
                      style: const TextStyle(fontSize: 20))),
          Positioned(
            left: 40,
            bottom: 40,
            child: Listener(
              onPointerDown: (details) {
                handleLeftPress();
              },
              onPointerUp: (x) {
                handleNoPress();
              },
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 280,
            bottom: 40,
            child: Listener(
              onPointerDown: (details) {
                handleRightPress();
              },
              onPointerUp: (x) {
                handleNoPress();
              },
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Listener(
              onPointerDown: (details) {
                handleUpPress();
              },
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Spiel verlassen"),
          content: const Text("Willst du das Spiel wirklich verlassen?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Ja"),
              onPressed: () {
                socketManager.webSocketChannel?.sink.close();

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Nein"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
