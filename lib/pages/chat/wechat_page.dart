import 'package:WECHATAPP_USE_FLUTTER/const.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/chat.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/search_bar.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/friends/friend_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeChatPage extends StatefulWidget {
  @override
  _WeChatPageState createState() => _WeChatPageState();
}

class _WeChatPageState extends State<WeChatPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  List <Chat> _datas = [];
  bool _cancelConnect = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    getDatas().then(
      (List<Chat> datas){
        if (!_cancelConnect) {
          setState(() {
            _datas = datas;
          });
        }
        print(datas);
      }
    ).catchError( (e){
      print(e);
    }).timeout(Duration(seconds: 20)).catchError(
      (timeout) {
      print('超时:${timeout}');
      _cancelConnect = true;
    }).whenComplete( (){
      print('完成');
    }) ;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<List<Chat>> getDatas() async { //异步执行 和 await 一块使用
    // http.get(url) 发出请求 
    _cancelConnect = false;
    final response = await http.get('http://rap2api.taobao.org/app/mock/224518/api/chat/list');
    if (response.statusCode == 200) {

      final responseBody = json.decode(response.body);
      List _listDatas = (responseBody['chat_list']).map<Chat> (
        (item) => Chat.formJson(item)
      ).toList();

      return _listDatas;
    }else {
      throw Exception('statusCode: ${response.statusCode}');
    }
  }

  List<PopupMenuItem<String>> _buildPopupMenuItem(BuildContext context) {
    
    return <PopupMenuItem<String>>[
      _itemBuilder('发起群聊', 'images/group_chat.png'),
      _itemBuilder('添加朋友', 'images/add_friend.png'),
      _itemBuilder('扫一扫', 'images/scan1.png'),
      _itemBuilder('收付款', 'images/sfk.png'),
    ];
          
  }

  PopupMenuItem<String> _itemBuilder(String name, String img){
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          Image(image: AssetImage(img),width: 25,),
          SizedBox(width: 15,),
          Text(name, style: TextStyle(
            color: Colors.white,
          ),),
        ],
      ),
    );
  }

  Widget _cellBuilder(BuildContext context, int index){
    if (index == 0){
      return Container(
        color: weChatThemeColor,
        height: 44,
        child: SearchCell(datas: _datas,),
      );
    }

    return ListTile(
      title: Text(_datas[index-1].name),
      subtitle: Container(
        width: 20,
        height: 20,
        child: Text(_datas[index-1].message, overflow: TextOverflow.ellipsis,),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_datas[index-1].imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: weChatThemeColor,
        centerTitle: true,
        title: Text('微信'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              offset: Offset(0, 60),
              child: Image(image: AssetImage('images/yj.png'),width: 25,),
              itemBuilder: _buildPopupMenuItem,
            )
          )
        ],
      ),
      body: Container(
        child: _datas.length == 0 ? Center(child: Text('Loading...'))
             : ListView.builder(
          itemCount: _datas.length+1,
          itemBuilder:_cellBuilder
        )
      ),
    );
  }
}

/* FutureBuilder用于比较简单的网络请求
Center(
        child: FutureBuilder(
          future: _datas,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: Text('Loading...'),);
            }else{
              return ListView(
                children: snapshot.data.map<Widget>((item) {
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Container(
                      width: 20,
                      height: 20,
                      child: Text(item.message, overflow: TextOverflow.ellipsis,),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.imageUrl),
                    ),
                  );
                }).toList(),
              );
            }
          },
        )
      ),
    )*/