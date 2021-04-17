import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:optionchain/Details.dart';
import 'package:optionchain/OptionBloc.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Option Chain',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Option chain'),
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
  OptionBloc _optionBloc = OptionBloc();

  void navigationWith(String data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OptionChainDetails(mainTitle: "$data")));
  }

  @override
  void initState() {
    _optionBloc.getCookies();
    super.initState();
  }

  ElevatedButton raisedButton(String title) {
    return ElevatedButton(
      onPressed: () {
        navigationWith("$title");
      },
      child: new Text("$title"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            raisedButton("NIFTY"),
            raisedButton("BANKNIFTY"),
            raisedButton("FINNIFTY"),
          ],
        ),
      ),
    );
  }
}
