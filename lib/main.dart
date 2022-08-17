import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lyrics/lyrics.dart';

import 'lyrics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final Stream<QuerySnapshot> Songs =
      FirebaseFirestore.instance.collection("Songs").snapshots();

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lyrics",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Lyrics"),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: Songs,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Text("we have a problem");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
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
                                  data.docs[index]["song_name"],
                                  data.docs[index]["artist"],
                                  data.docs[index]["song_url"],
                                  data.docs[index]["song_lyrics"],
                                  data.docs[index]["image"]))),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          data.docs[index]["song_name"],
                        ),
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
