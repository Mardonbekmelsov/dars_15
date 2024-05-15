import 'package:dars_15/pages/secon_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _textController = TextEditingController();

  late String userName;
  late String userChoice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    userChoice = "X";
                  },
                  child: Text("X"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    userChoice = "O";
                  },
                  child: Text("O"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: const ContinuousRectangleBorder(),
                  backgroundColor: Colors.blue),
              onPressed: () {
                userName = _textController.text;
                _textController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeconPage(
                      userName: userName,
                      user: userChoice,
                      bot: userChoice == "X" ? "O" : "X",
                    ),
                  ),
                );
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
