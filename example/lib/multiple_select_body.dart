import 'package:flutter/material.dart';

import 'multiple_select_route.dart';
import 'multiple_select_tem.dart';

List<MultipleSelectItem<int, String, String>> _dataList = List.generate(15, (index) {
  return MultipleSelectItem.build(value: index, display: '第$index项显示内容', content: '第$index项下拉内容');
});

Widget multipleSelectBody = Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      _cardHead,
      Expanded(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0, color: Colors.black54),
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            MultipleSelectItem<int, String, String> item = _dataList[index];
            return Text(index.toString());
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
  margin: EdgeInsets.only(top: 120),
);

Widget _cardHead = Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: <Widget>[
    MaterialButton(
      onPressed: () {
        print('hello');
      },
      child: Text(
        '取消',
        style: TextStyle(color: Colors.black54, fontSize: 18),
      ),
    ),
    MaterialButton(
      onPressed: () {
        print('world');
      },
      child: Text(
        '确定',
        style: TextStyle(color: Colors.blue, fontSize: 18),
      ),
    ),
  ],
);


