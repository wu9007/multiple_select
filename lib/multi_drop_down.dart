import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List<MultipleSelectItem> elements);

class MultipleDropDown extends StatefulWidget {
  final List<MultipleSelectItem> elements;
  final OnConfirm onConfirm;
  final String placeholder;
  final List<MultipleSelectItem> values;

  MultipleDropDown({this.values, @required this.elements, @required this.onConfirm, this.placeholder});

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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: this._getContent(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                    child: Icon(Icons.list, color: Colors.black54),
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
        MultipleSelect.showMultipleSelector(
          context,
          elements: this.widget.elements,
        ).then((selectedList) {
          if (selectedList != null) {
            this.setState(() => this._selectedElements = selectedList);
            this.widget.onConfirm(this._selectedElements);
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
            color: Colors.grey.shade500,
            decoration: TextDecoration.none,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 5),
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
                  label: Text(element.display),
                  onDeleted: () {
                    MultipleSelectItem clickElement = this.widget.elements.singleWhere((item) => item.value == element.value);
                    clickElement.selected = false;
                    this.setState(() => this._selectedElements.remove(element));
                    this.widget.onConfirm(this._selectedElements);
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
      this._selectedElements = this.widget.values;
      for (MultipleSelectItem item in this.widget.elements) {
        item.selected = false;
        for (MultipleSelectItem selectedItem in this._selectedElements) {
          if (item.value == selectedItem.value && !item.selected) {
            item.selected = true;
          }
        }
      }
    }
  }
}
