import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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

  String text = '';
  String textNumber = '';


  List<AudioFile> audiolist = [
    AudioFile(
        title: 'salut',
        url:
        'salut.mp3',
),
    AudioFile(
        title: 'salut(Germana)',
        url:
        'salut(germana).mp3',
 ),
    AudioFile(
        title: 'ma numesc',
        url:
        'ma-numesc.mp3',
 ),
    AudioFile(
      title: 'ma numesc(Germana)',
      url:
      'ma-numesc(germana).mp3',
    ),
    AudioFile(
      title: 'cum esti?',
      url:
      'cum esti.mp3',
    ),
    AudioFile(
      title: 'cum esti?(Germana)',
      url:
      'cum esti(germana).mp3',
    ),
    AudioFile(
      title: 'sunt bine',
      url:
      'sunt bine.mp3',
    ),
    AudioFile(
      title: 'sunt bine(Germana)',
      url:
      'sunt bine(germana).mp3',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Basic Phrases')),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: audiolist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return AnimatedContainer(
              constraints: const BoxConstraints.expand(),
              margin: const EdgeInsetsDirectional.all(16.0),
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              child: Material(
                color: Colors.blue,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: InkWell(
                  onTap: ()  async {
                      playLocalAsset(index);
                  },

                  child: Center(
                      child: Text(audiolist[index].title,
                          style: const TextStyle(fontSize: 14,
                              color: Colors.white)
                      )
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Future<AudioPlayer> playLocalAsset(index) async {
    AudioCache cache = AudioCache();
    return await cache.play(audiolist[index].url);
  }
}

