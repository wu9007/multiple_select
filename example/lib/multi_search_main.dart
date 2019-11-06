import 'package:flutter/material.dart';
import 'package:multiple_select/multi_search.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multiple Select Demo Page'),
        ),
        body: MultiSearchSelect(
          placeholder: '搜索',
          tail: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
            child: Icon(Icons.list, color: Colors.black54, size: 25),
          ),
        ),
      ),
    );
  }
}
