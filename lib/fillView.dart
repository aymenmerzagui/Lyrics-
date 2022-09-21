import 'dart:async';
import 'lyric.dart';
import 'package:flutter/material.dart';
import 'lyrics.dart';
import 'package:audioplayers/audioplayers.dart';
import 'globals.dart' as global;

class fillView extends StatelessWidget {
  late final Lyric? lyric;


  fillView({
    required this.lyric,
  });

  Widget elv1() {
    return ElevatedButton(onPressed: () {
      global.filled = false;
    },
        child: Text("fill"));


  }

  Widget elv2() {
    return ElevatedButton(onPressed: () {
      global.filled = true;
    },
        child: Text("fill"));


  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Center(
              child: Text(
                lyric!.text,
                style: TextStyle(color: Colors.white),
              ),
            ),
            elv1(),elv2()
          ],
        ));
  }
}
