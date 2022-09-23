import 'dart:async';

import 'lyric.dart';
import 'package:flutter/material.dart';
import 'lyrics.dart';
import 'package:audioplayers/audioplayers.dart';
import 'globals.dart' as global;




class fillView extends StatefulWidget {
  late final Lyric? lyric;
  late final bool isfilling;
  final VoidCallback pause ;
  final VoidCallback resume ;
  fillView({
    required this.lyric,
    required this.isfilling,
    required this.pause,
    required this.resume
  });

  @override
  State<fillView> createState() => _fillViewState();
}





class _fillViewState extends State<fillView> with TickerProviderStateMixin {
  late String answer ="";
  late List<String> wordList ;
  late List<String> items=[] ;

  void initState() {
  super.initState();
  wordList=widget.lyric!.text.split(" ");
  items=widget.lyric!.text.split(" ");
  wordList.shuffle();



  }
  List<ElevatedButton> listOfButtons() {



    List<ElevatedButton> buttonsList = <ElevatedButton>[];
    for (int i = 0; i < wordList.length; i++) {
      buttonsList
          .add(new ElevatedButton(onPressed: (){
            if(wordList[i]==items[0]){
              print(wordList[i]);
              changeText(wordList[i]);
              items.remove(items[0]);
              wordList.remove(wordList[i]);


            }
      }, child: Text(wordList[i],style: TextStyle(fontSize: 25),), style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        onSurface: Colors.grey,
      )));}
    if(wordList.isEmpty){
      widget.resume();
    }
    return buttonsList;

  }




  changeText(String s) {
    setState(() {
      answer = answer + s+" ";
    });
  }
    @override
  Widget build(BuildContext context) {

    if(widget.isfilling){
      widget.pause();
    }
    return
      Scaffold(body:



      Column(children: [

        SizedBox(height: 50,),
        Text(answer,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 60),),
          SizedBox(height: 200,),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            direction: Axis.horizontal ,
        children:
         listOfButtons(),
        )
      ],));

  }


}
