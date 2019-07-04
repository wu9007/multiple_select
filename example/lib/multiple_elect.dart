import 'package:flutter/material.dart';

class MultipleSelect extends StatefulWidget {
  MultipleSelect({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MultipleSelectState createState() => _MultipleSelectState();
}

class _MultipleSelectState extends State<MultipleSelect> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  bool _folded = true;
  double _unfoldedHeight = 600;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _animation = Tween(begin: 0.0, end: this._unfoldedHeight).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Stack(
          children: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  this._folded = !this._folded;
                });
                this._folded ? this._controller.reverse(from: this._animation.value) : this._controller.forward(from: this._animation.value);
              },
              color: Colors.amber,
              child: Icon(Icons.child_friendly),
            ),
            Positioned(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _cardHead,
                    Expanded(
                      child: _cardBody,
                    ),
                  ],
                ),
                decoration:
                    BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5.0,
                  ),
                ]),
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
              ),
              bottom: 0,
              top: MediaQuery.of(context).size.height - this._animation.value,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[300],
      ),
    );
  }

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

  static List<MultipleSelectItem<int, String, String>> _dataList = List.generate(15, (index) {
    return MultipleSelectItem.build(value: index, display: '第$index项显示内容', content: '第$index项下拉内容');
  });

  Widget _cardBody = ListView.separated(
    separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0, color: Colors.black54),
    itemCount: _dataList.length,
    itemBuilder: (context, index) {
      MultipleSelectItem<int, String, String> item = _dataList[index];
      return ListTile(
        title: Text(item.value.toString()),
        subtitle: Text(item.content),
        onTap: () {
          print('选中' + item.display);
        },
      );
    },
  );
}

class MultipleSelectItem<V, D, C> {
  V value;
  D display;
  C content;

  MultipleSelectItem.build({@required this.value, @required this.display, @required this.content});
}
