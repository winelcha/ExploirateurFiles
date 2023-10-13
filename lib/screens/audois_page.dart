import 'package:gestion_file/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  final String audioFilePath;

  const AudioPlayerPage({super.key, required this.audioFilePath});

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer audioPlayer;
  bool isRunnig = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer(playerId: widget.audioFilePath.toString());
    _playAudio();
  }

  void _playAudio() async {
    if (!isRunnig) {
      await audioPlayer.play(DeviceFileSource(widget.audioFilePath));
      isRunnig = true;
    } else {
      _resumeAudio();
    }
  }

  void _pauseAudio() async {
    await audioPlayer.pause();
  }

  void _resumeAudio() async {
    await audioPlayer.resume();
  }

  void _stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(text: 'Lecture audio'),
      body: _buildAudioPage(),
    );
  }

  Widget _buildAudioPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          const SizedBox(
              height: 300, width: 300, child: ColoredBox(color: Colors.grey)),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
              height: 5, width: 280, child: ColoredBox(color: Colors.grey)),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _playAudio();
                },
                child: const Icon(Icons.play_circle_fill_rounded,
                    color: Colors.white, size: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  _pauseAudio();
                },
                child: const Icon(Icons.pause_circle_filled_rounded,
                    color: Colors.white, size: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  _stopAudio();
                },
                child: const Icon(Icons.stop_circle_rounded,
                    color: Colors.white, size: 30),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
