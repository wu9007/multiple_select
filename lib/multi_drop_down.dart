import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List selectedValues);

/// 下拉多选
/// Created by Shusheng.
class MultipleDropDown extends StatelessWidget {
  final List values;
  final List<MultipleSelectItem> elements;
  final OnConfirm onConfirm;
  final String placeholder;
  final bool disabled;

  MultipleDropDown({
    Key key,
    @required this.values,
    @required this.elements,
    @required this.onConfirm,
    this.placeholder,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: this._getContent(),
                  ),
                  Opacity(
                    opacity: this.disabled ? 0.5 : 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                      child: Icon(Icons.list, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]))),
            ),
          ),
        ],
      ),
      onTap: () {
        if (!disabled)
          MultipleSelect.showMultipleSelector(
            context,
            elements: elements,
            values: this.values,
          ).then((values) {
            this.onConfirm(values);
          });
      },
    );
  }

  Widget _getContent() {
    if (this.values.length <= 0 && this.placeholder != null) {
      return Padding(
        child: Text(
          this.placeholder,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            decoration: TextDecoration.none,
          ),
        ),
        padding: EdgeInsets.only(top: 6, bottom: 6, left: 10),
      );
    } else {
      return Wrap(
        children: this
            .elements
            .where((element) => this.values.contains(element.value))
            .map(
              (element) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: RawChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.redAccent.shade400,
                    child: Text(element.display.toString().substring(0, 1)),
                  ),
                  isEnabled: !this.disabled,
                  label: Text(element.display),
                  onDeleted: () {
                    if (!this.disabled) {
                      this.values.remove(element.value);
                      this.onConfirm(this.values);
                    }
                  },
                ),
              ),
            )
            .toList(),
      );
    }
  }
}
