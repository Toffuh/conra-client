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
    print('Left button pressed');
    socketManager.webSocketChannel?.sink.add("direction:left");
  }

  void handleRightPress() {
    print('Right button pressed');
    socketManager.webSocketChannel?.sink.add("direction:right");
  }

  void handleUpPress() {
    print('Up button pressed');
    socketManager.webSocketChannel?.sink.add("jump:");
  }

  void handleNoPress() {
    print('No button pressed');
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
            bottom: 40,
            child: Listener(
              onPointerDown: (details) {
                print("down");
                handleLeftPress();
              },
              onPointerUp: (x) {
                print("up");
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
                print("down");
                handleRightPress();
              },
              onPointerUp: (x) {
                print("up");
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
            child: ElevatedButton(
              onPressed: handleUpPress,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(80, 80)),
              child: const Icon(Icons.arrow_circle_up),
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
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Navigiere zurück
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
