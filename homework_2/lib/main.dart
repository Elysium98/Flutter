import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  // runApp(const MyApp());
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();

  String text = '';
  String textButton = 'Guess';
  bool propertyKeyboard = true;
  static Random ran = new Random();
  int guessedNumber = ran.nextInt(99) + 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Guess my number')),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.all(16.0),
              child: Text(
                "I'm thinking of a number between 1 and 100.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                "It's your turn to guess my number!",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                text,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.all(16.0),
              height: 180,
              child: Card(
                elevation: 10.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Try a number!",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.all(16.0),
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        enabled: propertyKeyboard,
                        decoration: InputDecoration(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          try {
                            if (textButton.contains('Reset')) {
                              text = '';
                              propertyKeyboard = true;
                              textButton = 'Guess';
                            } else {
                              int input = int.parse(controller.text);
                              if (input > 99 || input < 1) {
                                text = "Choose number between 1 and 100";
                                controller.clear();
                                return;
                              }
                              if (input > guessedNumber) {
                                text = "You tried $input \n  Try lower!";
                              } else if (input < guessedNumber) {
                                text = "You tried $input \n Try higher";
                              } else {
                                alertDialog(context);
                                guessedNumber = ran.nextInt(99) + 1;
                                FocusScope.of(context).unfocus();
                                text = "You tried $input \n You guessed right";
                              }
                              controller.clear();
                            }
                          } on FormatException {
                            text = "Invalid number";
                          }
                        });
                      },
                      child: Text(textButton,
                          style: TextStyle(color: Colors.black)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white30)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("You guessed right"),
      content: Text("It was $guessedNumber"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Try again!');
            setState(() {
              text = '';
            });
          },
          child: const Text('Try again!'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Ok');
            setState(() {
              if (textButton.contains('Guess')) {
                textButton = 'Reset';
                propertyKeyboard = false;
              }
            });
          },
          child: const Text('OK'),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
