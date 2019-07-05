import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'multiple_select_tem.dart';

class SelectorList<T> extends StatefulWidget {
  final List<MultipleSelectItem> dataList;
  final double height;

  SelectorList({@required this.dataList, this.height = 150});

  @override
  State<StatefulWidget> createState() => SelectorListState();
}

class SelectorListState extends State<SelectorList> {
  List<MultipleSelectItem> _dataList;

  @override
  initState() {
    super.initState();
    this._dataList = widget.dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
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
                  Navigator.pop(context, this._dataList.where((item) => item.selected).toList());
                },
                child: Text(
                  '确定',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0, color: Colors.black54),
              itemCount: this._dataList.length,
              itemBuilder: (context, index) {
                MultipleSelectItem item = this._dataList[index];
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
                            fontSize: 18,
                            color: Colors.black,
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
