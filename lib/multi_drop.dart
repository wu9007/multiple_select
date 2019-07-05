import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List<MultipleSelectItem> elements);

class MultipleDropSelector extends StatefulWidget {
  final List<MultipleSelectItem> elements;
  final OnConfirm onConfirm;
  final String placeholder;
  final double width;

  MultipleDropSelector({@required this.elements, @required this.onConfirm, this.placeholder, this.width});

  @override
  State<StatefulWidget> createState() => MultipleDropSelectorState();
}

class MultipleDropSelectorState extends State<MultipleDropSelector> {
  List<MultipleSelectItem> _selectedElements = [];
  double _width;

  @override
  void initState() {
    super.initState();
    if (widget.width == null) {
      this._width = MediaQuery.of(context).size.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: this._getContent(),
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ))),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        width: this._width,
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
      return Text(this.widget.placeholder);
    } else {
      return ListView(
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
      );
    }
  }
}
