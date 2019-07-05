# multiple_select_example

```dart
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';
import 'package:multiple_select/multiple_select_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        body: Builder(
          builder: (context) => MaterialButton(
            onPressed: () {
              MultipleSelect.showMultipleSelector(
                context,
                dataList: List.generate(15, (index) => MultipleSelectItem.build(value: index, display: '第$index项显示内容', content: '第$index项下拉内容')),
              ).then((selectedList) {
                if (selectedList != null) selectedList.forEach((item) => print(item.display));
              });
            },
            color: Colors.deepOrange,
            child: Icon(Icons.blur_on),
          ),
        ),
      ),
    );
  }
}

```