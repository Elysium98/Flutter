import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class AudioFile {
  final String title;
  final String url;

  AudioFile({required this.title, required this.url});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _turn = true;
  int _selectedBoxes = 0;
  final List<String> _xOrOList = <String>[
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  final List<Color> _colorList = <Color>[
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Center(
              child: Text(
            'Tic Tac Toe',
            style: TextStyle(color: Colors.black),
          )),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                _tapped(index);
              },
              splashColor: Colors.red,
              child: AnimatedContainer(
                decoration: BoxDecoration(color: _colorList[index], border: Border.all(color: Colors.grey)),
                constraints: const BoxConstraints.expand(),
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              ),
            );
          },
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (_turn && _xOrOList[index] == '') {
        _xOrOList[index] = 'o';
        _colorList[index] = Colors.blue;
        _selectedBoxes += 1;
      } else if (!_turn && _xOrOList[index] == '') {
        _xOrOList[index] = 'x';
        _colorList[index] = Colors.red;
        _selectedBoxes += 1;
      }

      _turn = !_turn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (_xOrOList[0] == _xOrOList[1] && _xOrOList[0] == _xOrOList[2] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    if (_xOrOList[3] == _xOrOList[4] && _xOrOList[3] == _xOrOList[5] && _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      return;
    }

    if (_xOrOList[6] == _xOrOList[7] && _xOrOList[6] == _xOrOList[8] && _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      return;
    }

    if (_xOrOList[0] == _xOrOList[3] && _xOrOList[0] == _xOrOList[6] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    if (_xOrOList[1] == _xOrOList[4] && _xOrOList[1] == _xOrOList[7] && _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      return;
    }

    if (_xOrOList[2] == _xOrOList[5] && _xOrOList[2] == _xOrOList[8] && _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    if (_xOrOList[0] == _xOrOList[4] && _xOrOList[0] == _xOrOList[8] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    if (_xOrOList[2] == _xOrOList[4] && _xOrOList[2] == _xOrOList[6] && _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    if (_selectedBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    var alert = AlertDialog(
      title: Text(winner),
      content: Text(title),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Reset!');
            setState(() {
              _clearBoard();
            });
          },
          child: const Text('Reset'),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOrOList[i] = '';
        _colorList[i] = Colors.white;
      }
    });

    _selectedBoxes = 0;
  }
}
