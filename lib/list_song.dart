import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lyrics/lyrics.dart';
import 'main.dart';
import 'lyrics.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class list_song extends StatefulWidget {
  late String level;

  list_song(this.level);

  State<StatefulWidget> createState() {
    return list_songState();
  }
}

Widget row(String song_name, String artist, String image) {
  return


    Container(



      padding: EdgeInsets.all(0),
      decoration:BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          )
      ),

      child:


      Row(
          mainAxisSize: MainAxisSize.max,


          children: [

        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)
              ,
              image: DecorationImage(

                image: NetworkImage(image)
                ,
                fit: BoxFit.cover
              )
          ),
        )
        ,
        SizedBox(width: 20.0,),
        Column(

          children: [
            Text(song_name,
              style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600),),
            SizedBox(height: 5.0,),
            Text(artist, style: TextStyle( fontSize: 15,fontWeight: FontWeight.w600),)

          ],
        ),new Spacer(),
          Icon(Icons.music_note_outlined),new Spacer()]));
}

class list_songState extends State<list_song> {

  final Stream<QuerySnapshot> Songs =
  FirebaseFirestore.instance.collection("Songs").snapshots();

  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: const Icon(Icons.list,color: Colors.black45,),
        title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
    child:

    Text(
    "My Playlist",
    style: TextStyle(
    fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
    ),


    ),
    ),
    body :
    Container(
      color: Colors.lightBlueAccent,
      child:
    StreamBuilder<QuerySnapshot>(
    stream: Songs,
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasError) {
    return Text("we have a problem");
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
    print("wait");
    return Center(child:CircularProgressIndicator());
    }
    final data = snapshot.requireData;

    return ListView.builder(
    itemCount: data.size,
    itemBuilder: (context, index) {
    return InkWell(
    onTap: () => Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => lyrics(
    data.docs[index]["level"],
    data.docs[index]["song_name"],
    data.docs[index]["artist"],
    data.docs[index]["song_url"],
    ))),

    child:
    (data.docs[index]["level"] == widget.level)
    ?
    Column(children: [
      SizedBox(height: 10,),
    row(data.docs[index]["song_name"],data.docs[index]["artist"] ,data.docs[index]["image"]),SizedBox(width: 10,height: 10,)],) :
    SizedBox(height: 0,)
    );

    },
    );
    })
    ,
    )
    );
  }
}
