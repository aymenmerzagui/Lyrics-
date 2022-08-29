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

  lyrics(this.song_name, this.artist, this.song_url, this.song_lyrics,
      this.image);

  @override
  State<lyrics> createState() => _lyricsState();
}

class _lyricsState extends State<lyrics> {

  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool ispaused = false;
  bool isplaying = false;
  bool isloop = false;
  LyricController lyricController = LyricController();
  ScrollController _scrollController = ScrollController(initialScrollOffset: 70);

  List<IconData> icons = [Icons.play_circle_fill, Icons.pause_circle_filled];
  AudioPlayer audioPlayer = AudioPlayer();

  void initState() {
    super.initState();
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        _position = event;
        print(_position);
        lyricController.updateCurrentLyrics(event);
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    audioPlayer.setSourceUrl(widget.song_url);
  }


  Future<void> play() async {
    return await audioPlayer.play(UrlSource(widget.song_url));
  }


  @override
  Widget build(BuildContext context) {
    lyricController.init(widget.song_name);
    play();

    return MaterialApp(
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: lyricController.statusMessageStream.stream,
          builder: (context, snapshot) {
            return Center(
                child:
                 showLyrics()


            );
          },
        ));
  }

Padding showLyrics(){
  return Padding(padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: StreamBuilder<List<Lyric?>>(
        stream: lyricController.lyricsStream.stream,
        builder: (context,lyricsSnapshot){
          return StreamBuilder<int>(
              stream: lyricController.highlightedLyricIdxStream.stream,
              builder: (context,idxSnapshot){
                print(idxSnapshot.data);
                if (idxSnapshot!=null&& idxSnapshot.hasData) {
                  var height = 52.0;

                  _scrollController.animateTo(
                    lyricsView.padding + idxSnapshot.data! * 200,
                    duration: Duration(milliseconds: lyricsView.animationDuration),
                    curve: Curves.easeOutCubic,
                  );
                }
                return lyricsView(lyrics: lyricsSnapshot.data??[], highlightedLyricIdx: idxSnapshot.data ?? -1);
              });
        },
      ),
  );
}}
