import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multiple_select/Item.dart';

class MultiFilterSelectPage extends StatefulWidget {
  final String placeholder;
  final List<Item> allItems;
  final List initValue;
  final bool autoFocusKeyboard;

  MultiFilterSelectPage({
    this.placeholder,
    @required this.allItems,
    @required this.initValue,
    this.autoFocusKeyboard
  });

  @override
  State<StatefulWidget> createState() => MultiFilterSelectPageState();
}

class MultiFilterSelectPageState extends State<MultiFilterSelectPage> {
  List<Item> filterItemList;
  List selectedItemValueList;

  @override
  void initState() {
    super.initState();
    this.selectedItemValueList = this.widget.initValue;
    this.filterItemList = this.widget.allItems;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.arrow_back_ios, size: 20),
                ),
                onTap: () => Navigator.pop(context, this.selectedItemValueList),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 33, maxWidth: 280),
                child: TextField(
                  onChanged: (text) {
                    this.filterItemList = this
                        .widget
                        .allItems
                        .where((item) =>
                            item.display.toString().contains(text) ||
                            item.content.toString().contains(text))
                        .toList();
                    this.setState(() {});
                  },
                  autofocus: this.widget.autoFocusKeyboard??true,
                  style: TextStyle(fontSize: 14),
                  cursorColor: Colors.grey,
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 0, bottom: 0, left: 10),
                      fillColor: Colors.black12,
                      filled: true,
                      suffixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none),
                      hintText: this.widget.placeholder ?? 'search……'),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: filterItemList.map(
                (item) {
                  bool _selected =
                      this.selectedItemValueList.contains(item.value);
                  return GestureDetector(
                    onTap: () {
                      if (_selected) {
                        this.selectedItemValueList.remove(item.value);
                      } else {
                        this.selectedItemValueList.add(item.value);
                      }
                      this.setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Text(
                        item.content,
                        style: TextStyle(fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                        color: _selected ? Colors.blue[50] : Colors.grey[200],
                        border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color:
                                _selected ? Colors.blue[200] : Colors.black12),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
      onWillPop: () {
        Navigator.pop(context, this.selectedItemValueList);
        return new Future.value(false);
      },
    );
  }
}
