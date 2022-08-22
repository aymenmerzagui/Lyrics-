import 'lyric.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class lyrics_Source {
  Future<String> fetchlrcfile(String song_lyrics) async {
    return await rootBundle.loadString('lrcfiles/$song_lyrics');
  }
  Future<List<Lyric?>?> fetchLyrics(String song_lyrics) async {
    return (await fetchlrcfile(song_lyrics))
        .split("\n")
        ?.map((lyric) {
          var match = RegExp(r"\[(\d+):(\d+\.\d+)\](.*)").firstMatch(lyric);
          if (match != null) {
            var min = int.parse(match.group(1).toString());
            var sec = double.parse(match.group(2).toString());
            var lyric = match.group(3);
            return Lyric(
                Duration(
                    minutes: min,
                    seconds: sec.floor(),
                    milliseconds: ((sec % 1) * 1000).floor()),
                lyric!);
          } else {
            return null;
          }
        })
        ?.where((lyric) => lyric != null)
        ?.toList();
  }
}
