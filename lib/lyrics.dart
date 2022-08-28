import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';

import 'lyric.dart';
import 'package:lyrics/lyricsViewer.dart';
import 'lyrics_source.dart';
import 'lyricsViewer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:status_view/status_view.dart';

import 'package:music/music.dart';

class lyrics extends StatefulWidget {
  final song_name, artist, song_url, song_lyrics, image;

  lyrics(
      this.song_name, this.artist, this.song_url, this.song_lyrics, this.image);

  @override
  State<lyrics> createState() => _lyricsState();
}

class _lyricsState extends State<lyrics> {

  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool ispaused = false;
  bool isplaying = false;
  bool isloop = false;

  List<IconData> icons = [Icons.play_circle_fill, Icons.pause_circle_filled];
  AudioPlayer audioPlayer = AudioPlayer();
  void initState() {
    super.initState();
    audioPlayer.onPositionChanged.listen((event) { setState(() {
      _position=event;
    });});
    audioPlayer.onDurationChanged.listen((event) {setState(() {
      _duration=event;
    });});
    audioPlayer.setSourceUrl(widget.song_url);
  }





  play() {
    audioPlayer.play(UrlSource(widget.song_url));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(child: IconButton(
      onPressed: () {
        play();
      },
      icon: Icon(Icons.play_circle_fill),
    ))));
  }
}
