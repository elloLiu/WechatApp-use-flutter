import 'package:WECHATAPP_USE_FLUTTER/const.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/discover/discover_cell.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
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

  Widget headerWidget() {
    return GestureDetector(
      onTap: (){
          print('click/show info');
      },
      child: Container(
        color: Colors.white,
        height: 200,
        child: Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(left: 15),
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  // child: Image(image: AssetImage('images/62.png'),),
                  decoration: BoxDecoration( //添加了装饰器只是container圆角了，child：Image不会被圆角，要想圆角就要用装饰器里边的image，背景图片
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(image: AssetImage('images/62.png'), fit: BoxFit.cover)
                  ),
                ),//头像
                // Container( // 计算剩余屏幕宽度
                //   width: MediaQuery.of(context).size.width-110,
                //   color: Colors.blue,
                // ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 35,
                          alignment: Alignment.centerLeft,
                          child: Text('LLL', style: TextStyle(
                            fontSize: 25.0,
                          ),),
                        ),
                        Container(
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('微信号：123', style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.grey
                              ),),
                              Image(image: AssetImage('images/icon_right.png'),width: 15,)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: weChatThemeColor,
        child: Stack(
          children: <Widget>[
            Container(
              height: 800,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: <Widget>[
                    headerWidget(),
                    SizedBox(height: 10,),
                    DiscoverCell(title: '支付',imgName: 'images/WechatPay.png',),
                    SizedBox(height: 10,),
                    DiscoverCell(title: '收藏',imgName: 'images/WechatCol.png',),
                    Row(children: <Widget>[
                      Container(color: Colors.white, width: 50,height: 0.5,),
                      Container(color: Colors.grey, height: 0.5,),
                    ],),
                    DiscoverCell(title: '相册',imgName: 'images/WechatXC.png',),
                    Row(children: <Widget>[
                      Container(color: Colors.white, width: 50,height: 0.5,),
                      Container(color: Colors.grey, height: 0.5,),
                    ],),
                    DiscoverCell(title: '卡包',imgName: 'images/WechatCard.png',),
                    Row(children: <Widget>[
                      Container(color: Colors.white, width: 50,height: 0.5,),
                      Container(color: Colors.grey, height: 0.5,),
                    ],),
                    DiscoverCell(title: '表情',imgName: 'images/WechatEmoji.png',),
                    SizedBox(height: 10,),
                    DiscoverCell(title: '设置',imgName: 'images/WechatSet.png',),
                    ],
                    
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10),
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image(image: AssetImage('images/Camera.png'),)
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}