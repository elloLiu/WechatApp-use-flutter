import 'package:WECHATAPP_USE_FLUTTER/const.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/discover/discover_cell.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: weChatThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text('发现', ),
      ),
      body: Container(
        color: weChatThemeColor,
        height: 800,
        child: ListView(
          children: <Widget>[
            DiscoverCell(
              title: '朋友圈',
              imgName: 'images/pyq.png',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '扫一扫',
              imgName: 'images/scan_2.png',
            ),
            Row(children: <Widget>[
              Container(color: Colors.white, width: 50,height: 0.5,),
              Container(color: Colors.grey, height: 0.5,),
            ],),
            DiscoverCell(
              title: '摇一摇',
              imgName: 'images/shake.png',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '看一看',
              imgName: 'images/look.png',
            ),
            Row(children: <Widget>[
              Container(color: Colors.white, width: 50,height: 0.5,),
              Container(color: Colors.grey, height: 0.5,),
            ],),
            DiscoverCell(
              title: '搜一搜',
              imgName: 'images/search.png',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '附近的人',
              imgName: 'images/nearby.png',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '购物',
              imgName: 'images/shopping.png',
              subTitle: '618特惠大活动',
              subImgName: 'images/badge.png',
            ),
            Row(children: <Widget>[
              Container(color: Colors.white, width: 50,height: 0.5,),
              Container(color: Colors.grey, height: 0.5,),
            ],),
            DiscoverCell(
              title: '游戏',
              imgName: 'images/game2.png',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '小程序',
              imgName: 'images/small_program.png',
            ),
          ],
        ),
      ),
    );
  }
}