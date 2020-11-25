import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

import 'package:multiple_select/multi_drop_down.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

List<MultipleSelectItem> elements = List.generate(
  15,
  (index) => MultipleSelectItem.build(
    value: index,
    display: '$index display',
    content: '$index content',
  ),
);

List _selectedValues = elements
    .where((element) => element.value % 2 == 0)
    .map((item) => item.value)
    .toList();

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Select Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multiple Select Demo Page'),
        ),
        body: MultipleDropDown(
          placeholder: '请选择单据',
          disabled: false,
          values: _selectedValues,
          elements: elements,
        ),
      ),
    );
  }
}
