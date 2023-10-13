import 'package:exploirateurfile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  final String audioFilePath;

  AudioPlayerPage({required this.audioFilePath});

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio();
  }
void _playAudio() async {
  // Source audioSource = AudioSource.uri(Uri.parse(widget.audioFilePath));
  // await audioPlayer.play(audioSource);
}




  void _pauseAudio() async {
    await audioPlayer.pause();
  }

  void _stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.black,
      appBar: appbar(text: 'Lecture audio'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _playAudio();
              },
              child: Text('Lire'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _pauseAudio();
              },
              child: Text('Pause'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _stopAudio();
              },
              child: Text('Arrêter'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
