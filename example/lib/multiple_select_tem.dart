import 'package:flutter/material.dart';

class MultipleSelectItem<V, D, C> {
  V value;
  D display;
  C content;

  MultipleSelectItem.build({@required this.value, @required this.display, @required this.content});
}