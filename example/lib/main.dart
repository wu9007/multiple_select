import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'multiple_elect_bak.dart';
import 'multiple_select_route.dart';

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
              showMultipleSelector(
                context,
                theme: Theme.of(context, shadowThemeOnly: true),
              );
            },
            color: Colors.deepOrange,
            child: Icon(Icons.blur_on),
          ),
        ),
      ),
    );
  }
}

showMultipleSelector(
  BuildContext context, {
  ThemeData theme,
}) {
  Navigator.push(
    context,
    MultipleSelectRoute(
      theme: theme,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    ),
  );
}
