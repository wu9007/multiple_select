library multiple_select;

import 'package:flutter/material.dart';

import 'package:multiple_select/src/multiple_select_route.dart';
import 'package:multiple_select/src/multiple_select_item.dart';

class MultipleSelect {
  ///
  /// Display multiple selector bottom sheet.
  ///
  static Future showMultipleSelector(BuildContext context, {@required List<MultipleSelectItem> dataList}) {
    return Navigator.push(
      context,
      MultipleSelectRoute<List<MultipleSelectItem>>(barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel, dataList: dataList),
    );
  }
}
