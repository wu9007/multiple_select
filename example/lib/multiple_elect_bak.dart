import 'package:flutter/material.dart';

import 'multiple_select_body.dart';
import 'multiple_select_route.dart';

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
  double _unfoldedHeight = 700;

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
            Row(
              children: <Widget>[
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
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MultipleSelectRoute(theme: Theme.of(context, shadowThemeOnly: true), barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel),
                    );
                  },
                  color: Colors.deepOrange,
                  child: Icon(Icons.blur_on),
                ),
              ],
            ),
            Positioned(
              child: multipleSelectBody,
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
}
