import 'package:flutter/material.dart';

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


  bool isplaying = false;

  bool isfilling=true;
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

    /*audioPlayer.setSourceUrl(widget.song_url);*/
  }

  Future<void> play() async {
    return await audioPlayer.play(
      AssetSource('music/${widget.song_name}'+'.mp3')
      /*UrlSource(widget.song_url)*/);
  }
  Future<void> resume() async {
    isfilling=false;
    return await audioPlayer.resume();

  }
  Future <void> pause() async{
    isplaying=false;
    return  audioPlayer.pause();

  }
  Widget fill(Lyric? lyric){
    if(isfilling){
      pause();
    }
    return
       Center(child:Column(children : listOfButtons(lyric!),))


    ;
  }

  List<ElevatedButton> listOfButtons(Lyric lyric) {

    var wordList = lyric.text.split(" ");
    List<ElevatedButton> buttonsList = <ElevatedButton>[];
    for (int i = 0; i < wordList.length; i++) {
      buttonsList
          .add(new ElevatedButton(onPressed: null, child: Text(wordList[i]), style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
      )));}
    buttonsList.shuffle();
    return buttonsList;

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
                if((idxSnapshot.data!%global.niveau==0)&&(idxSnapshot.data!=0)){


                  return fillView( lyric: lyricsSnapshot.data![idxSnapshot.data!],isfilling: isfilling,pause: pause,resume: resume,);
                }}
                isfilling=true;
                  return lyricsView(lyrics: lyricsSnapshot.data ?? [],
                      highlightedLyricIdx: idxSnapshot.data ?? -1);




              });
        },
      ),
    ));
  }
}

