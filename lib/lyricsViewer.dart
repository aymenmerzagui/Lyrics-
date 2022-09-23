
import 'package:lyrics/fillView.dart';
import 'globals.dart'as global;
import 'lyric.dart';
import 'package:flutter/material.dart';

class lyricsView extends StatelessWidget {
  late final List<Lyric?>? lyrics;
  static final ScrollController _scrollController = ScrollController();

  late final double lyricSize;
  late final int? highlightedLyricIdx;
  static final double padding = 50;

  static final int animationDuration = 250;

  lyricsView({
    required this.lyrics,
    required this.highlightedLyricIdx,
    this.lyricSize = 30.0,
  });
void dispose(){
  _scrollController.dispose();
}
  void scroll(int x, BuildContext y) {
    var height = 90.0;
    _scrollController.animateTo(
      lyricsView.padding + x * height - (MediaQuery
          .of(y)
          .size
          .height / 6),
      duration: Duration(milliseconds: lyricsView.animationDuration),
      curve: Curves.easeOutCubic,
    );
  }


  fillOrText(Lyric lyric) {
        return Text(lyric.text);
  }

  Widget lyricLine(BuildContext context, int lyricIdx, Lyric lyric) {
    TextStyle? style;
  if((lyricIdx%global.niveau==0)&&(lyricIdx!=0)){

    if ((lyricIdx == highlightedLyricIdx)||(lyricIdx > highlightedLyricIdx!) ){
    style = Theme
        .of(context)
        .textTheme
        .headline1!
        .copyWith(color: Colors.transparent, fontSize: lyricSize,fontWeight: FontWeight.bold);}
    else{
      style = Theme
          .of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.white24, fontSize: lyricSize,);
    }

  }else{

      if (lyricIdx == highlightedLyricIdx) {

        style = Theme
            .of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.white, fontSize: lyricSize,fontWeight: FontWeight.bold);
      } else if (lyricIdx < highlightedLyricIdx!) {
        style = Theme
            .of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white24, fontSize: lyricSize,);
      } else {
        style = Theme
            .of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white30, fontSize: lyricSize,);
      }}



    /*if((lyricIdx%3==0)&&(lyricIdx==highlightedLyricIdx)){

      return fillView(lyric: lyric);


    }
*/    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: AnimatedDefaultTextStyle(
        style: style,
        duration: Duration(microseconds: animationDuration),
        curve: Curves.easeOutCubic,
        softWrap: true,
        child: fillOrText(lyric)

        ),

    );
  }

// asMap :The map uses the indices of this list as keys and the corresponding objects as values. The Map.keys Iterable iterates the indices of this list in numerical order.
  //MapEntry : add things to the map

  @override
  Widget build(BuildContext context) {
    if(highlightedLyricIdx!=0){
      scroll(highlightedLyricIdx!, context);
    }

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
        controller: _scrollController,
        children: <Widget>[topPadding] + lyricsWidgets! + <Widget>[downPadding]
    );
  }
}
