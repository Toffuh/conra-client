import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Conra"),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.settings))
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
            TextButton(
              onPressed: _nameController.text.isEmpty
                  ? null
                  : () {
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
}
