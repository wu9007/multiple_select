import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List selectedValues);

class MultipleDropDown extends StatefulWidget {
  final List values;
  final List<MultipleSelectItem> elements;
  final OnConfirm onConfirm;
  final String placeholder;
  final bool disable;

  MultipleDropDown({
    this.values,
    @required this.elements,
    @required this.onConfirm,
    this.placeholder,
    this.disable = false,
  });

  @override
  State<StatefulWidget> createState() => MultipleDropDownState();
}

class MultipleDropDownState extends State<MultipleDropDown> {
  List<MultipleSelectItem> _selectedElements = [];
  double _width;

  @override
  void initState() {
    super.initState();
    this._initElement();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: this._getContent(),
                  ),
                  Opacity(
                    opacity: this.widget.disable ? 0.5 : 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                      child: Icon(Icons.list, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]))),
              padding: EdgeInsets.symmetric(horizontal: 2),
              width: this._width,
            ),
          ),
        ],
      ),
      onTap: () {
        if (!this.widget.disable)
          MultipleSelect.showMultipleSelector(
            context,
            elements: this.widget.elements,
          ).then((selectedList) {
            if (selectedList != null) {
              this.setState(() => this._selectedElements = selectedList);
              this.widget.onConfirm(this._selectedElements.map((element) => element.value).toList());
            } else {
              this._initElement();
            }
          });
      },
    );
  }

  Widget _getContent() {
    if (this._selectedElements.length <= 0 && this.widget.placeholder != null) {
      return Padding(
        child: Text(
          this.widget.placeholder,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            decoration: TextDecoration.none,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      );
    } else {
      return Wrap(
        children: this
            ._selectedElements
            .map(
              (element) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: RawChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.redAccent.shade400,
                    child: Text(element.display.toString().substring(0, 1)),
                  ),
                  isEnabled: !this.widget.disable,
                  label: Text(element.display),
                  onDeleted: () {
                    if (!this.widget.disable) {
                      MultipleSelectItem clickElement = this.widget.elements.singleWhere((item) => item.value == element.value);
                      clickElement.selected = false;
                      this.setState(() => this._selectedElements.remove(element));
                      this.widget.onConfirm(this._selectedElements);
                    }
                  },
                ),
              ),
            )
            .toList(),
      );
    }
  }

  _initElement() {
    if (this.widget.values != null && this.widget.values.length > 0) {
      this._selectedElements = [];
      for (MultipleSelectItem item in this.widget.elements) {
        item.selected = false;
        for (dynamic value in this.widget.values) {
          if (item.value == value && !item.selected) {
            item.selected = true;
            this._selectedElements.add(item);
          }
        }
      }
    }
  }
}
