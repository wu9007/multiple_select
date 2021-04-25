import 'package:flutter/material.dart';

class Item<V, D, C> {
  V value;

  /// display in the TextField
  D display;

  /// display in the list content.
  C content;

  Item.build({
    required this.value,
    required this.display,
    required this.content,
  });

  Item.fromJson(
    Map<String, dynamic> json, {
    displayKey = 'display',
    valueKey = 'value',
    contentKey = 'content',
  })  : value = json[valueKey] ?? '' as V,
        display = json[displayKey] ?? '' as D,
        content = json[contentKey] ?? '' as C;

  static List<Item> allFromJson(
    List jsonList, {
    displayKey = 'display',
    valueKey = 'value',
    contentKey = 'content',
  }) {
    return jsonList
        .map((json) => Item.fromJson(
              json,
              displayKey: displayKey,
              valueKey: valueKey,
              contentKey: contentKey,
            ))
        .toList();
  }
}
