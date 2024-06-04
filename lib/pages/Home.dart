import 'dart:convert';

import 'package:conra_client/provider/urlProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();

  final String name = "";
  final Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Conra"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, "/settings"),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 32.0),
              child: SizedBox(
                width: 600,
                child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Ihr Name"),
                    onChanged: (value) {
                      setState(() {});
                    }),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: _currentColor,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _pickColor(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    minimumSize: const Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  child: const Text("Wählen Sie eine Farbe aus!"),
                ),
                const SizedBox(height: 20),
              ],
            ),
            TextButton(
              onPressed: _nameController.text.isEmpty
                  ? null
                  : () {
                      UrlProvider urlProvider =
                          Provider.of<UrlProvider>(context, listen: false);

                      sendName(urlProvider.url);

                      Navigator.pushNamed(context, "/controller",
                          arguments: _nameController.text);
                    },
              style: TextButton.styleFrom(
                minimumSize: const Size(100, 50),
                backgroundColor: _nameController.text.isEmpty
                    ? Colors.grey
                    : Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              child:
                  const Text("Spielen", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Color _currentColor = Colors.blue;

  void _pickColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Wählen Sie eine Farbe aus!"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Fertig"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  sendName(String path) async {
    var body = jsonEncode({"name": _nameController.text});
    var headers = {"Content-Type": "application/json"};

    await post(Uri.parse("$path/api/join"), headers: headers, body: body);
  }
}
