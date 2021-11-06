import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled=true;
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final TextEditingController controller = TextEditingController();

  String? errorText;
  String text = '';


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text('Currency convertor')
          ),
        ),
        body: Column(
          children: <Widget>[
           Image.network('https://media.alephnews.ro/2021/04/bani-salarii-1070x600.jpg',
             height: 100,
             width: 500,
             fit: BoxFit.fitWidth,
             ),
            Container(
              margin:EdgeInsetsDirectional.all(16.0),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (String? value){
                  final String value = controller.text;
                  final double? currentValue = double.tryParse(value);

                  setState(() {
                    if(currentValue == null){
                      errorText = 'enter a valid number';
                       text = '';

                    } else{
                      errorText = null;
                    }

                  });
                },
                decoration:  InputDecoration(
                  hintText: 'enter the amount in Euro',
                  errorText: errorText,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  final String value = controller.text;
                  final double? currentValue = double.tryParse(value);
                  final double? inputValue =  currentValue;
                  final double? euro =  inputValue! * 4.50;

                  setState(() {
                      text = euro!.toStringAsFixed(2) + ' RON';


                  });

                },
                child: Text('CONVERT!',
                  style: TextStyle(color: Colors.black)
                ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white30)),
               ),
            Text(text,
              style: TextStyle(fontSize: 30,
              color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}