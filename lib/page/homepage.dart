import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_gank/bean/fulibean.dart';


class homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new homepageState();
}

class homepageState extends State<homepage> {
  var text = "首页";
  List body2 = new List();
  List result = new List();
  _getData(int itemCount, int pageNo) async {
    var url = "http://gank.io/api/data/福利/$itemCount/$pageNo";
    var httpClient = new HttpClient();
    try {
      var requst = await httpClient.getUrl(Uri.parse(url));
      var response = await requst.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var body = JSON.decode(json);
        body2 = body["results"];
        print(body2.length.toString());
        setState(() {
          result = body2;
        });
      }
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("GankForFlutter"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: null,
              accountEmail: null,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525245474130&di=aaae1ef3810e23ad4bc83776f464a2f2&imgtype=0&src=http%3A%2F%2Fp1.gexing.com%2FG1%2FM00%2F22%2FF1%2FrBACFFV__62QgOT_AAL0nmK3Qpc264.jpg'))
              ),
            ),
            new ListTile(
              title: new Text("新闻"),
              leading: new Icon(Icons.fiber_new),
              onTap: () {
                _getData(50, 2);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("美图"),
              leading: new Icon(Icons.image),
              onTap: () {
                _getData(50, 3);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("视频"),
              leading: new Icon(Icons.video_label),
              onTap: () {
                _getData(50, 4);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("游戏"),
              leading: new Icon(Icons.games),
              onTap: () {
                _getData(50, 5);
                Navigator.of(context).pop();
              },
            ),
            new Divider(),


          ],
        ),
      ),
      body: result.length <= 0 ? new Container(
        child: new Center(child: new Text("空视图"),),
      ) :
      new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemCount: result.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Column(
                children: <Widget>[
                  new Image(
                      width: 320.0,
                      image: new NetworkImage(result[index]['url']),
                  ),
                  new Center(child: new Text(result[index]['desc']))
                ],
              ),
            );
          }),
    );
  }

}