import 'package:flutter/material.dart';

class MultipleSelectItem<V, D, C> {
  V value;
  D display;

  /// drop down content.
  C content;

  /// if this element was selected.
  bool selected;

  MultipleSelectItem.build({@required this.value, @required this.display, @required this.content, this.selected = false});
}
