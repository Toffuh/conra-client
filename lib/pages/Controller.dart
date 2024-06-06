import 'dart:async';

import 'package:conra_client/provider/urlProvider.dart';
import 'package:conra_client/utils/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class Controller extends StatefulWidget {
  final Color color;
  final String name;

  const Controller({super.key, required this.color, required this.name});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  late SocketManager socketManager;

  Timer? _timer;

  @override
  void initState() {
    UrlProvider urlProvider = Provider.of<UrlProvider>(context, listen: false);

    socketManager = SocketManager(urlProvider.url);

    sendColor(widget.color);

    _startTimer();

    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void sendColor(Color color) {
    socketManager.webSocketChannel?.sink.add("color:#${color.toHexString()}");
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
              right: 40,
              top: 40,
              child: Text("Name: ${widget.name}",
                  style: const TextStyle(fontSize: 20))),
          Positioned(
              right: 40,
              top: 70,
              child: SizedBox(
                width: 60.0,
                height: 60.0,
                child: Container(
                    decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10.0),
                )),
              )),
          Positioned(
              left: 40,
              top: 40,
              child: Text("Kills: ${socketManager.kills}",
                  style: const TextStyle(fontSize: 20))),
          Positioned(
              left: 40,
              top: 60,
              child: Text("Deaths: ${socketManager.deaths}",
                  style: const TextStyle(fontSize: 20))),
          Positioned(
              left: 40,
              top: 80,
              child: socketManager.deaths == 0
                  ? Text("KD: ${socketManager.kills}",
                      style: const TextStyle(fontSize: 20))
                  : Text(
                      "KD: ${(socketManager.kills / socketManager.deaths).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20))),
          Positioned(
            bottom: -10,
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
                  width: 60.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 120,
            bottom: -10,
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
                  width: 60.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: -10,
            child: Listener(
              onPointerDown: (details) {
                handleUpPress();
              },
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_circle_up_rounded,
                        color: Colors.white,
                      ),
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
