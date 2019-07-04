import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'multiple_elect.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Select Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultipleSelect(title: 'Multiple Select Demo Page'),
    );
  }
}


