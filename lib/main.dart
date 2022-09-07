import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:volume_control/volume_control.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _playSound() async {
    double _currVolume = await VolumeControl.volume;
    VolumeControl.setVolume(1);
    AudioCache _bgmCache =
        AudioCache(fixedPlayer: new AudioPlayer(), respectSilence: false);
    _bgmCache
        .play(
          'sound.mp3',
          isNotification: false,
        )
        .whenComplete(() => {
              Future.delayed(const Duration(seconds: 10), () {
                VolumeControl.setVolume(_currVolume);
              })
            });
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _playSound,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
