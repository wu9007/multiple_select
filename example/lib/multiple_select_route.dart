import 'package:flutter/material.dart';

import 'multiple_select_body.dart';

class MultipleSelectRoute<T> extends PopupRoute<T> {
  final ThemeData theme;
  final String barrierLabel;

  MultipleSelectRoute({
    this.theme,
    this.barrierLabel,
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
      child: multipleSelectBody,
    );
    if (theme != null) {
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}
