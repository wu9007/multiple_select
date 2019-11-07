import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String placeholder;

  SearchPage({this.placeholder});

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        title: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 30, maxWidth: 250),
          child: TextField(
            style: TextStyle(fontSize: 13),
            cursorColor: Colors.grey,
            cursorWidth: 1.5,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10),
                fillColor: Colors.black12,
                filled: true,
                suffixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                hintText: this.widget.placeholder ?? 'search……'),
          ),
        ),
      ),
      body: null,
    );
  }
}
