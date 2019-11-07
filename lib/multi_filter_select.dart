import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select_page.dart';

typedef SelectCallback = Function(List selectedValue);

/// 模糊查询多选
class MultiFilterSelect extends StatefulWidget {
  final double height;
  final String placeholder;
  final double fontSize;
  final Widget tail;
  final List<Item> allItems;
  final List initValue;
  final SelectCallback selectCallback;

  MultiFilterSelect({
    this.height,
    this.placeholder,
    this.fontSize,
    this.tail,
    @required this.allItems,
    this.initValue,
    @required this.selectCallback,
  });

  @override
  State<StatefulWidget> createState() => MultiFilterSelectState();
}

class MultiFilterSelectState extends State<MultiFilterSelect> {
  List _selectedValue = [];

  @override
  void initState() {
    super.initState();
    if (this.widget.initValue != null && this.widget.initValue.length > 0) this._selectedValue = this.widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        this._selectedValue = await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MultiFilterSelectPage(
                  allItems: this.widget.allItems,
                  initValue: this.widget.initValue ?? [],
                )));
        this.setState(() {});
        this.widget.selectCallback(_selectedValue);
      },
      child: this._selectedValue.length > 0 ? this._getValueWrp() : this._getEmptyWrp(),
    );
  }

  Widget _getEmptyWrp() {
    return Container(
      height: this.widget.height ?? 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              child: Text(
                this.widget.placeholder ?? '',
                style: TextStyle(fontSize: this.widget.fontSize ?? 16, color: Colors.black26, decoration: TextDecoration.none),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
            ),
          ),
          this.widget.tail ??
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                child: Icon(Icons.list, color: Colors.black54, size: 25),
              ),
        ],
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]))),
    );
  }

  Widget _getValueWrp() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: this
            .widget
            .allItems
            .where((item) => this._selectedValue.contains(item.value))
            .map((item) => GestureDetector(
                  onLongPress: () {
                    this._selectedValue.remove(item.value);
                    this.setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Text(
                      item.content,
                      style: TextStyle(fontSize: 15),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ))
            .toList(),
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]))),
    );
  }
}
