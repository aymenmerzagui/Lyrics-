import 'package:flutter/material.dart';
import 'package:lyrics/list_song.dart';
import 'list_song.dart';
import 'globals.dart'as global;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme:new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
        home: test());
  }
}
class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              appBar: AppBar(
                title: Text("Lyrics"),
              ),
              body:
              Center(child :Column(children : [
                Text("Fill The Lyrics"),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient:
                        const LinearGradient(
                            colors: [Colors.blue, Colors.green]),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          global.niveau=6;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => list_song("Easy")),
                          );
                        },
                        child: const Text(
                          "Easy",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient:
                        const LinearGradient(
                            colors: [Colors.blue, Colors.green]),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          global.niveau=5;


                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => list_song("Medium")));
                        },
                        child: const Text(
                          "Medium",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient:
                        const LinearGradient(
                            colors: [Colors.blue, Colors.green]),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          global.niveau=3;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => list_song("Hard")),
                          );
                        },
                        child: const Text(
                          "Hard",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )])));

  }
}