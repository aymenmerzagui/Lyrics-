import 'dart:async';

import 'lyrics_source.dart';


class Lyric {
  late Duration time;

  late String text;

  Lyric(this.time, this.text);
}

class LyricController {
  var lyricsStream = StreamController<List<Lyric?>>.broadcast();
  var highlightedLyricIdxStream = StreamController<int>.broadcast();
  var statusMessageStream = StreamController<String?>.broadcast();
  late List<Lyric?> lastLyrics ;
  int lasthighlightedLyricIdx=-1;
  late lyrics_Source source = lyrics_Source();

  fetchNewLyrics(String song_name) async {
    statusMessageStream.sink.add("Loking for lyrics");
    var lyrics = await source.fetchLyrics(song_name);
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
    lastLyrics.asMap().forEach((lyricsIdx, lyric) {
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

  init(String song_name) {

      fetchNewLyrics(song_name);

  }

  dispose() {
    lyricsStream.close();
    highlightedLyricIdxStream.close();
  }
}





