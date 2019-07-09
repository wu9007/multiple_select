import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

import 'package:multiple_select/multi_drop_down.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

List<MultipleSelectItem> elements = List.generate(15, (index) => MultipleSelectItem.build(value: index, display: '$index display', content: '$index content'));

class MyAppState extends State<MyApp> {
  List _selectedValues = elements.where((element) => element.value % 2 == 0).map((item) => item.value).toList();

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
          placeholder: '请选择',
          disable: true,
          values: _selectedValues,
          elements: elements,
          onConfirm: (selectedValues) {
            this.setState(() => this._selectedValues = selectedValues);
          },
        ),
      ),
    );
  }
}
