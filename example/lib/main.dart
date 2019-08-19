import 'package:flutter/material.dart';
import 'package:fl_twitter_login/fl_twitter_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('Log with twitter'),
            onPressed: () => FlTwitterLogin.twitterLogin(),
          ),
        ),
      ),
    );
  }
}
