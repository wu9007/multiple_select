import 'package:flutter/material.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:multiple_select/Item.dart';

List<Item<num, String, String>> items = List.generate(
  150,
  (index) => Item.build(
    value: index,
    display: '$index display',
    content: '$index content',
  ),
);

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<num>? _initValue = [];

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
        body: Column(
          children: <Widget>[
            MultiFilterSelect(
              allItems: items,
              initValue: _initValue,
              autoOpenKeyboard: false,
              hintText: 'search...',
              selectCallback: (List? selectedValue) {
                print(selectedValue!.length);
              },
            ),
            MaterialButton(
              child: Text('change data'),
              onPressed: () {
                this.setState(() {
                  if (this._initValue!.length > 0) {
                    this._initValue = null;
                  } else {
                    this._initValue = [1, 2, 3];
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
