import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ImageDetail extends StatelessWidget {
  final url;

  ImageDetail({Key key, @required this.url}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("图片详情"),
      ),
      body: new Container(
        child: new Center(
          child: new Image(image: new NetworkImage(url)),
        ),
      ),
    );
  }

}
