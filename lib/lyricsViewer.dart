import 'dart:ui';
import 'lyric.dart';
import 'package:flutter/material.dart';

class lyricsView extends StatelessWidget {
  late final List<Lyric?>? lyrics;

  late final double lyricSize;
  late final int highlightedLyricIdx;
  static final double padding = 800;

  static final int animationDuration = 250;

  lyricsView({
    required this.lyrics,
    required this.highlightedLyricIdx,
    this.lyricSize = 25.0,
  });

  Widget lyricLine(BuildContext context, int lyricIdx, Lyric lyric) {
    TextStyle style;
    if (lyricIdx == highlightedLyricIdx) {
      style = Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(color: Colors.white, fontSize: lyricSize);
    } else if (lyricIdx < highlightedLyricIdx) {
      style = Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.white24, fontSize: lyricSize);
    } else {
      style = Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.white30, fontSize: lyricSize);
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: AnimatedDefaultTextStyle(
        style: style,
        duration: Duration(microseconds: animationDuration),
        curve: Curves.easeOutCubic,
        softWrap: true,
        child: Text(lyric.text),
      ),
    );
  }
// asMap :The map uses the indices of this list as keys and the corresponding objects as values. The Map.keys Iterable iterates the indices of this list in numerical order.
  //MapEntry : add things to the map

  @override
  Widget build(BuildContext context) {
    var topPadding = Container(
      constraints: BoxConstraints(minHeight: padding),);
    var lyricsWidgets = lyrics
        ?.asMap()
        .map((lyricIdx, lyric) =>
        MapEntry(lyricIdx, lyricLine(context, lyricIdx, lyric!)))
        .values
        .toList();
    var downPadding = Container(
      constraints: BoxConstraints(minHeight: padding),);
    return ListView(
        children: <Widget>[topPadding] + lyricsWidgets! + <Widget>[downPadding]
    );
  }
}
