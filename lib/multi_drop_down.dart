import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List<MultipleSelectItem> elements);

class MultipleDropDown extends StatefulWidget {
  final List<MultipleSelectItem> elements;
  final OnConfirm onConfirm;
  final String placeholder;

  MultipleDropDown({@required this.elements, @required this.onConfirm, this.placeholder});

  @override
  State<StatefulWidget> createState() => MultipleDropDownState();
}

class MultipleDropDownState extends State<MultipleDropDown> {
  List<MultipleSelectItem> _selectedElements = [];
  double _width;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: this._getContent(),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1,
              ))),
              padding: EdgeInsets.symmetric(horizontal: 2),
              width: this._width,
            ),
          )
        ],
      ),
      onTap: () {
        MultipleSelect.showMultipleSelector(
          context,
          dataList: this.widget.elements,
        ).then((selectedList) {
          if (selectedList != null) {
            this.setState(() => this._selectedElements = selectedList);
            this.widget.onConfirm(this._selectedElements);
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
            color: Colors.black,
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
                    this.widget.elements[this.widget.elements.indexOf(element)].selected = false;
                    this.setState(() => this._selectedElements.removeAt(this._selectedElements.indexOf(element)));
                    this.widget.onConfirm(this._selectedElements);
                  },
                ),
              ),
            )
            .toList(),
      );
    }
  }
}
