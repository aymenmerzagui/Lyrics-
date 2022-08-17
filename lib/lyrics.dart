import 'package:lyrics/lyrics.dart';
import 'package:flutter/material.dart';
 class lyrics extends StatefulWidget {
   final song_name,artist,song_url,song_lyrics,image ;
    lyrics(this.song_name,this.artist,this.song_url,this.song_lyrics,this.image);
   @override
   State<lyrics> createState() => _lyricsState();
 }
 
 class _lyricsState extends State<lyrics> {
   @override
   Widget build(BuildContext context) {
     return Container();
   }
 }
 