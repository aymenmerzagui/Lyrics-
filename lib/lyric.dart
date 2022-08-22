import 'dart:async';

import 'lyrics_source.dart';
import 'package:flutter/widgets.dart';

class Lyric {
  late Duration time;

  late String text;

  Lyric(this.time, this.text);
}

class LyricController {
  var lyricsStream = StreamController<List<Lyric?>>.broadcast();
  var highlightedLyricIdxStream = StreamController<int>.broadcast();
  var statusMessageStream = StreamController<String?>.broadcast();
  late List<Lyric?> lastLyrics;
  late int lasthighlightedLyricIdx;
  var _didInit = false;
  late lyrics_Source source = lyrics_Source();

  fetchNewLyrics(String song_lyrics) async {
    statusMessageStream.sink.add("Loking for lyrics");
    var lyrics = await source.fetchLyrics(song_lyrics);
    if (lyrics == null) {
      statusMessageStream.sink.add("Lyrics not found");
    } else {
      lastLyrics = lyrics;
      lyricsStream.sink.add(lyrics);
      statusMessageStream.sink.add(null);
    }
  }

  updateCurrentLyrics(Duration temps) async {
    if (temps == null) {
      return;
    }
    var newIdx = lasthighlightedLyricIdx;
    lastLyrics?.asMap()?.forEach((lyricsIdx, lyric) {
      if (temps >= lyric!.time) {
        newIdx = lyricsIdx;
      }
    });
    if (lasthighlightedLyricIdx != newIdx) {
      scrollToLyric(newIdx);
    }
  }

  scrollToLyric(int idx) {
    lasthighlightedLyricIdx = idx;
    highlightedLyricIdxStream.sink.add(idx);
  }
  init (String song_lyrics ,Stream <String> lyricsStream ,Stream<Duration> timeStream){
    if(!_didInit){
      lyricsStream.listen(fetchNewLyrics);
      timeStream.listen(updateCurrentLyrics);

    }}
dispose (){
  lyricsStream.close();
      highlightedLyricIdxStream.close();

}
  }

class currentSongController {
  var song_lyrics = StreamController<String> .broadcast();
  var timeStream = StreamController<Duration>.broadcast();
  late String lastSongLyrics ;
  Duration lastTime = Duration();
 var _didInit =false ;
  DBusClient _dbusClient;   //yield is like return but without ending the function

}
