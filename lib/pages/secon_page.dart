import 'dart:math';

import 'package:flutter/material.dart';

class SeconPage extends StatefulWidget {
  final String userName;
  final String user;
  final String bot;

  SeconPage({required this.userName, required this.user, required this.bot});

  @override
  State<SeconPage> createState() =>
      _SeconPageState(userName: userName, user: user, bot: bot);
}

class _SeconPageState extends State<SeconPage> {
  final String userName;
  final String user;
  final String bot;
  String winText = '';

  late String curPLayer;

  bool gameEnd = false;

  int userScore = 0;
  int botScore = 0;

  List<List<int>> winConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [2, 4, 6],
    [0, 4, 8]
  ];

  List spaces = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  List xo = ["", "", "", "", "", "", "", "", ""];

  List userChoices = [];
  List botChoices = [];

  _SeconPageState(
      {required this.userName, required this.user, required this.bot});

  @override
  void initState() {
    current_player();
    super.initState();
  }

  void current_player() {
    if (user == "X") {
      curPLayer = user;
    } else {
      curPLayer = bot;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (curPLayer == bot) {
      setState(() {
        if (spaces.isNotEmpty) {
          int index = spaces[Random().nextInt(spaces.length)];
          xo[index] = bot;
          botChoices.add(index);
          checkWin();
          spaces.removeWhere((element) => element == index);
          curPLayer = user;
        }
      });
    }
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 3),
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$userName  $userScore:$botScore  Computer",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                for (int i = 0; i < 9; i++)
                  InkWell(
                    onTap: () {
                      if (xo[i].isNotEmpty || gameEnd) {
                        return;
                      }
                      setState(() {
                        xo[i] = curPLayer;
                        userChoices.add(i);
                        if (!checkWin()) {
                          change_player();
                        }
                        spaces.removeWhere((element) => element == i);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      height: 100,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            xo[i],
                            style: const TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                backgroundColor: Colors.grey,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                setState(() {
                  current_player();
                  gameEnd = false;
                  xo = ["", "", "", "", "", "", "", "", ""];
                  spaces = [0, 1, 2, 3, 4, 5, 6, 7, 8];
                });
              },
              child: Text("New game"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                setState(() {
                  current_player();
                  gameEnd = false;
                  xo = ["", "", "", "", "", "", "", "", ""];
                  spaces = [0, 1, 2, 3, 4, 5, 6, 7, 8];
                  userScore = 0;
                  botScore = 0;
                });
              },
              child: Text("Reset game"),
            ),
            Text(winText)
          ],
        ),
      ),
    );
  }

  void change_player() {
    if (curPLayer == user) {
      curPLayer = bot;
    } else {
      curPLayer = user;
    }
  }

  bool checkWin() {
    for (var win in winConditions) {
      String position0 = xo[win[0]];
      String position1 = xo[win[1]];
      String position2 = xo[win[2]];

      if (position0.isNotEmpty) {
        if (position0 == position1 && position0 == position2) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     backgroundColor: Colors.green,
          //     content: Text(
          //       "$curPLayer won",
          //       style: const TextStyle(fontSize: 24),
          //     ),
          //   ),
          // );
          if (curPLayer == user) {
            userScore += 1;
          } else if (curPLayer == bot) {
            botScore += 1;
          }
          gameEnd = true;
          return true;
        }
      }
    }
    return false;
  }
}
