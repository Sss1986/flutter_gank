import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_gank/bean/fulibean.dart';
import 'PhotoHero.dart';


class homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<homepage> {
  var type = 'all';
  var count = 20;
  var pageNo = 1;
  List body2 = new List();
  List result = new List();


  _getData(String type, int count, int pageNo) async {
    var res = await _getString(type, count, pageNo);
    if (!mounted) return;
    setState(() {
      result = JSON.decode(res)['results'];
    });
  }

  Future<String> _getString(String type, int count, int pageNo) async {
    var url = "http://gank.io/api/data/$type/$count/$pageNo";
    var httpClient = new HttpClient();
    var requst = await httpClient.getUrl(Uri.parse(url));
    var response = await requst.close();
    return await response.transform(UTF8.decoder).join();
  }

  @override
  void initState() {
    super.initState();
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
              title: new Text("全部"),
              leading: new Icon(Icons.star_half),
              onTap: () {
                _getData(type = "all", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("福利"),
              leading: new Icon(Icons.image),
              onTap: () {
                _getData(type = "福利", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Android"),
              leading: new Icon(Icons.android),
              onTap: () {
                setState(() {
                  type = "Android";
                  count = 20;
                  pageNo = 1;
                });
                _getData(type = "Android", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("iOS"),
              leading: new Icon(Icons.format_align_justify),
              onTap: () {
                _getData(type = "iOS", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("休息视频"),
              leading: new Icon(Icons.video_library),
              onTap: () {
                _getData(type = "休息视频", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("前端"),
              leading: new Icon(Icons.web),
              onTap: () {
                _getData(type = "前端", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("拓展资源"),
              leading: new Icon(Icons.games),
              onTap: () {
                _getData(type = "拓展资源", count, pageNo);
                Navigator.of(context).pop();
              },
            ),
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
            return new GestureDetector(
              child: new Card(
                child: result[index]['url'].toString().endsWith(".jpg") ||
                    result[index]['url'].toString().endsWith(".jpeg") == true ?
                new Column(
                    children: <Widget>[
                      new PhotoHero(
                          photo: result[index]['url'], width: 300.0, onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new Scaffold(
                                appBar: new AppBar(
                                  backgroundColor: Colors.redAccent,
                                  title: new Text("圖片詳情"),
                                ),
                                body: new Container(
                                  child: new Center(
                                    child: new PhotoHero(
                                      photo: result[index]['url'],
                                      width: 400.0,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },),
                                  ),
                                ),
                              );
                            }));
                      })
                    ]) : new Column(
                  children: <Widget>[
                    
                    new Text(result[index]['desc'])
                  ],),
              ),
            );
          }),
    );
  }
}

