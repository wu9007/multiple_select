library multiple_select;

import 'package:flutter/material.dart';

class MultipleSelect {
  ///
  /// Display multiple selector bottom sheet.
  ///
  static Future showMultipleSelector(BuildContext context, {@required List<MultipleSelectItem> elements}) {
    return Navigator.push(
      context,
      MultipleSelectRoute<List<MultipleSelectItem>>(barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel, elements: elements),
    );
  }
}

class MultipleSelectRoute<T> extends PopupRoute<T> {
  final String barrierLabel;
  final List<MultipleSelectItem> elements;

  MultipleSelectRoute({
    this.barrierLabel,
    this.elements,
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
      child: SelectorList(elements: this.elements),
    );
    ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    if (theme != null) {
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class SelectorList<T> extends StatefulWidget {
  final List<MultipleSelectItem> elements;
  final double height;

  SelectorList({@required this.elements, this.height = 150});

  @override
  State<StatefulWidget> createState() => SelectorListState();
}

class SelectorListState extends State<SelectorList> {
  List<MultipleSelectItem> _elements;

  @override
  initState() {
    super.initState();
    this._elements = widget.elements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context, this._elements.where((item) => item.selected).toList());
                  },
                  child: Text(
                    '确定',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
              ],
            ),
            height: 50,
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0, color: Colors.black54),
              itemCount: this._elements.length,
              itemBuilder: (context, index) {
                MultipleSelectItem item = this._elements[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Text(
                          item.content.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: item.selected
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.check_circle_outline,
                                  size: 30,
                                ),
                          onTap: () {
                            this.setState(() => item.selected = !item.selected);
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 5.0,
        ),
      ]),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
      margin: EdgeInsets.only(top: this.widget.height),
    );
  }
}

class MultipleSelectItem<V, D, C> {
  V value;
  D display;

  /// drop down content.
  C content;

  /// if this element was selected.
  bool selected;

  MultipleSelectItem.build({@required this.value, @required this.display, @required this.content, this.selected = false});

  MultipleSelectItem.fromJson(Map<String, dynamic> json, {displayKey, valueKey, contentKey})
      : value = json[valueKey ?? 'value'] ?? '',
        display = json[displayKey ?? 'display'] ?? '',
        content = json[contentKey ?? 'content'] ?? '';

  static List<MultipleSelectItem> allFromJson(List jsonList, {valueKey, displayKey, contentKey}) {
    return jsonList.map((json) => MultipleSelectItem.fromJson(json, displayKey: displayKey, valueKey: valueKey, contentKey: contentKey)).toList();
  }
}
