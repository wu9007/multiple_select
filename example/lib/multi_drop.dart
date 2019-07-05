import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List<MultipleSelectItem> elements);

class MultipleDropSelector extends StatefulWidget {
  final List<MultipleSelectItem> elements;
  final OnConfirm onConfirm;

  MultipleDropSelector({@required this.elements, @required this.onConfirm});

  @override
  State<StatefulWidget> createState() => MultipleDropSelectorState();
}

class MultipleDropSelectorState extends State<MultipleDropSelector> {
  List<MultipleSelectItem> _selectedElements = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: this
              ._selectedElements
              .map(
                (element) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
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
        ),
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ))),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
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
}
