import 'package:flutter/material.dart';

import 'multiple_select_route.dart';
import 'multiple_select_tem.dart';

class MultipleSelect {
  static Future showMultipleSelector(BuildContext context, {@required List<MultipleSelectItem> dataList}) {
    return Navigator.push(
      context,
      MultipleSelectRoute<List<MultipleSelectItem>>(barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel, dataList: dataList),
    );
  }
}
