import 'package:flutter/material.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:multiple_select/Item.dart';

List<Item<num, String, String>> items = List.generate(
  150,
      (index) =>
      Item.build(
        value: index,
        display: '$index display',
        content: '$index content' * (index + 1),
      ),
);

List<num> _initValue = [1, 2, 10];

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
        body: MultiFilterSelect(
          allItems: items,
          initValue: _initValue,
          selectCallback: (List selectedValue) {
            print(selectedValue.length);
          },
        ),
      ),
    );
  }
}
