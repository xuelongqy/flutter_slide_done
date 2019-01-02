import 'package:flutter/material.dart';
import 'package:flutter_slide_done/slide_done.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide done demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Slide done demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // SlideDone key
  GlobalKey<SlideDoneState> slideDoneKey = new GlobalKey<SlideDoneState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          _basicStyle(),
          _justOpenStyle(),
          _flatStyle(),
          _customize(),
          _more()
        ],
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Basic
  Widget _basicStyle() {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Basic",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                SlideDone(
                  key: slideDoneKey,
                  onStart: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                  onEnd: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        slideDoneKey.currentState.callOnStart();
                      },
                      child: Text("Start")
                    ),
                    FlatButton(
                      onPressed: (){
                        slideDoneKey.currentState.callOnEnd();
                      },
                      child: Text("End")
                    ),
                  ],
                )
              ],
            )
        )
    );
  }

  // Just Open
  Widget _justOpenStyle() {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Just Open",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                SlideDone(
                  endText: Text("It's done",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  endedIcon: Icon(Icons.done,
                    color: Colors.white,
                  ),
                  endedText: Container(),
                  startedDelay: 0,
                  onEnd: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                  onStart: () {},
                ),
              ],
            )
        )
    );
  }

  // Flat style
  Widget _flatStyle() {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Flat style",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                SlideDone(
                  elevation: 0.0,
                  buttonElevation: 0.0,
                  backgroundColor: Colors.black26,
                  onStart: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                  onEnd: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                ),
              ],
            )
        )
    );
  }

  // 自定义
  Widget _customize() {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Customize",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                SlideDone(
                  width: 250.0,
                  height: 60.0,
                  padding: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  buttonShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0 - 3.0))
                  ),
                  startIcon: Icon(Icons.lock_outline,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  endIcon: Icon(Icons.lock_open,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  startText: Text("右滑开锁",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  startingText: Text("开启中...",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  startedText: Text("成功开锁",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  endText: Text("左滑锁定",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  endingText: Text("锁定中...",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  endedText: Text("锁定完成",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  startFillView: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.lens, size: 10.0,),
                        Container(width: 10.0,),
                        Icon(Icons.lens, size: 10.0,),
                        Container(width: 10.0,),
                        Icon(Icons.lens, size: 10.0,),
                        Container(width: 10.0,),
                        Icon(Icons.lens, size: 10.0,),
                      ],
                    ),
                  ),
                  endFillView: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.lens, size: 10.0,),
                        Container(width: 10.0,),
                        Icon(Icons.lens, size: 10.0,),
                        Container(width: 10.0,),
                        Icon(Icons.lens, size: 10.0,),
                        Container(width: 10.0,),
                        Icon(Icons.lens, size: 10.0,),
                      ],
                    ),
                  ),
                  onStart: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                  onEnd: () async {
                    await Future.delayed(Duration(seconds: 2), (){});
                  },
                ),
              ],
            )
        )
    );
  }

  // More
  Widget _more() {
    return Card(
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text("More",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
                SlideDone(
                  startText: Text("Get more",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  endText: Text("QQ群:554981921",
                    style: TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  endedIcon: Icon(Icons.done,
                    color: Colors.white,
                  ),
                  endedText: Container(),
                  startedDelay: 0,
                  endedDelay: 0,
                  onEnd: () {
                    launch("mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3DMNLtkvnn4n28UIB0gEgm2-WBmqmGWk0Q");
                  },
                  onStart: () {},
                ),
              ],
            )
        )
    );
  }
}
