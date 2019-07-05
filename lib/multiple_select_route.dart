import 'package:flutter/material.dart';

import 'multiple_select_item.dart';
import 'selector_list.dart';

class MultipleSelectRoute<T> extends PopupRoute<T> {
  final String barrierLabel;
  final List<MultipleSelectItem> dataList;

  MultipleSelectRoute({
    this.barrierLabel,
    this.dataList,
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 2000);

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: SelectorList(dataList: this.dataList),
    );
    ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    if (theme != null) {
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}
