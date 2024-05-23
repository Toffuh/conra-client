import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Controller extends StatelessWidget {
  const Controller({super.key});

  void handleLeftPress() {
    print('Left button pressed');
  }

  void handleRightPress() {
    print('Right button pressed');
  }

  void handleUpPress() {
    print('Up button pressed');
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
            left: 20,
            bottom: 40,
            child: ElevatedButton(
              onPressed: handleLeftPress,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(80, 80)),
              child: const Icon(Icons.arrow_circle_left),
            ),
          ),
          Positioned(
            left: 220,
            bottom: 40,
            child: ElevatedButton(
              onPressed: handleRightPress,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(80, 80)),
              child: const Icon(Icons.arrow_circle_right),
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
