import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();

  String text = '';
  String textNumber = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Number Shapes')),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.all(16.0),
              child: const Text(
                "Please input a number to see if it is  perfect square or cube",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.all(16.0),
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsetsDirectional.all(16.0),
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    try {
                      int currentValue = int.parse(controller.text);

                      num x = pow(currentValue * 1.0, 1.0 / 3).round();
                      int integer = sqrt(currentValue).truncate();

                      if ((x * x * x == currentValue) & (integer == sqrt(currentValue))) {
                        textNumber = controller.text;
                        text = "Number $textNumber is  perfect SQUARE and CUBE";
                      } else if (x * x * x == currentValue) {
                        textNumber = controller.text;
                        text = "Number $textNumber is  perfect CUBE";
                      } else if (integer == sqrt(currentValue)) {
                        textNumber = controller.text;
                        text = "Number $textNumber is perfect SQUARE";
                      } else {
                        textNumber = controller.text;
                        text = "Number $textNumber is neither  perfect SQUARE or CUBE";
                      }
                    } on FormatException {
                      textNumber = "Invalid number";
                      text = "";
                    }
                    alertDialog(context);
                  });
                },
                child: const Icon(Icons.check, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  primary: Colors.blue, // <-- Button color
                  onPrimary: Colors.red, // <-- Splash color
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void alertDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text(textNumber),
      content: Text(text),
      actions: const <Widget>[],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
