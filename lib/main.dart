import 'package:flutter/material.dart';
import 'youtubeextract.dart';
import 'dart:async';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'freetube',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = '';
  TextEditingController controllerurl1 = TextEditingController();
  String filename = '';
  double stats = 0.0;

  void settingstate() {
    Timer.periodic(const Duration(seconds:1), (Timer t) =>
        setState(() { stats = statistics; }));

  }





  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.live_tv,
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Freetube",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        body: Column(children: <Widget>[
          TextField(controller: controllerurl1, decoration: InputDecoration(hintText: "example: https://youtu.be/FfrAcQjlrsg", prefixIcon: Icon(Icons.content_paste), border: OutlineInputBorder(), helperText: "hit the share Icon and select copy url in the youtube app.",),),
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(color: Colors.black26, onPressed:  () {url = controllerurl1.text; extractvideo(url); settingstate();}, child: Text("submit for video")),
            ),
            FlatButton(color: Colors.black26, onPressed:  () {url = controllerurl1.text; extractaudio(url); settingstate();}, child: Text("submit for audio")),
          ]),
          Text(filename1),
          CircularProgressIndicator(value: stats,strokeWidth: 20,),
        ]));
  }
}