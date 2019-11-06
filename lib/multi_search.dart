import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/search_page.dart';

/// 模糊查询多选
class MultiSearchSelect extends StatefulWidget {
  final double height;
  final String placeholder;
  final double fontSize;
  final Widget tail;

  MultiSearchSelect({this.height, this.placeholder, this.fontSize, this.tail});

  @override
  State<StatefulWidget> createState() => MultiSearchSelectState();
}

class MultiSearchSelectState extends State<MultiSearchSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height ?? 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage())),
              child: Padding(
                child: Text(
                  this.widget.placeholder ?? '',
                  style: TextStyle(fontSize: this.widget.fontSize ?? 16, color: Colors.black26, decoration: TextDecoration.none),
                ),
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
              ),
            ),
          ),
          this.widget.tail,
        ],
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]))),
    );
  }
}
