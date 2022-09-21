import 'package:flutter/material.dart';
import 'package:lyrics/fillView2.dart';
import 'package:lyrics/lyricsViewer.dart';
import 'fillView.dart';
import 'lyric.dart';
import 'package:audioplayers/audioplayers.dart';
import 'globals.dart' as global;

class lyrics extends StatefulWidget {
  final song_name, artist, song_url,level;
  lyrics(this.level,this.song_name, this.artist, this.song_url);

  @override
  State<lyrics> createState() => _lyricsState();
}

class _lyricsState extends State<lyrics> {
  static Duration _position = new Duration();
  bool ispaused = false;
  bool isplaying = false;
  bool isloop = false;
  LyricController lyricController = LyricController();
  AudioPlayer audioPlayer = AudioPlayer();

  void dispose() {
    lyricController.dispose();
    super.dispose();
    audioPlayer.dispose();

  }

  void initState() {
    super.initState();


    audioPlayer.onPositionChanged.listen((event) {
      setState(() {

        _position = event;
        print(_position);
          lyricController.updateCurrentLyrics(event);

      });
    });

    audioPlayer.setSourceUrl(widget.song_url);
  }

  Future<void> play() async {
    return await audioPlayer.play(UrlSource(widget.song_url));
  }
  Future<void> resume() async {
    isplaying=true;
    return await audioPlayer.resume();

  }

  @override
  Widget build(BuildContext context) {
/*    print(global.filled);
    if(global.filled){
      setState(() {
        isplaying=true;
      });
    }else {
      setState(() {
        isplaying=false;
      });
    }*/

    lyricController.init(widget.song_name);
    play();



    return MaterialApp(

        home: StreamBuilder(
          stream: lyricController.statusMessageStream.stream,
          builder: (context, snapshot) {
            return Center(child: showLyrics());
          },
        ));
  }

  Container showLyrics() {

    return Container(
        color: Colors.blueGrey,
        child:
      Padding(


      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: StreamBuilder<List<Lyric?>>(
        stream: lyricController.lyricsStream.stream,
        builder: (context, lyricsSnapshot) {
          return StreamBuilder<int?>(
              stream: lyricController.highlightedLyricIdxStream.stream,
              builder: (context, idxSnapshot) {
                if(idxSnapshot.hasData){
                if(idxSnapshot.data!>1){

                  audioPlayer.pause();
                  return Center(child: ElevatedButton(onPressed: resume, child: Text("hello"),)
                    ,);
                }}
                    return lyricsView(lyrics: lyricsSnapshot.data ?? [],
                        highlightedLyricIdx: idxSnapshot.data ?? -1);




              });
        },
      ),
    ));
  }
}
/*
if ((lyricsSnapshot.data![idxSnapshot.data!+1]!.time ==
_position) */
/*&&(filled==false)*/ /*
) {
audioPlayer.pause();
print("condition");
}*/
