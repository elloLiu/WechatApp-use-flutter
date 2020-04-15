import 'package:WECHATAPP_USE_FLUTTER/const.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/friends/friend_data.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/friends/index_bar.dart';
import 'package:flutter/material.dart';



class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  AnimationController _controller;

  ScrollController _scrollController;

  final List _headerList = [
    _FriendsCell(imgAssets: 'images/new_friend.png',name: '新的朋友',),
    _FriendsCell(imgAssets: 'images/ql.png',name: '群聊',),
    _FriendsCell(imgAssets: 'images/sign.png',name: '标签',),
    _FriendsCell(imgAssets: 'images/gzh.png',name: '公众号',),
  ];

  final List<Friends> _listDatas = []; 

  final Map _groupOffsetMap = {
    INDEX_WORDS[0] : 0.0,
    INDEX_WORDS[1] : 0.0,
  };

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _scrollController = ScrollController();

    //.addAll不会返回数组，..addAll返回的是数组
    _listDatas..addAll(datas)..addAll(datas);
    _listDatas.sort((Friends a, Friends b){
      return a.indexLetter.compareTo(b.indexLetter);
    });

    var groupOffSet = 54.0*4;
    for(int i = 0; i < _listDatas.length; i++){
      if(i < 1){ //第一个cell包含头部
        _groupOffsetMap.addAll({_listDatas[i].indexLetter:groupOffSet});
        groupOffSet += 84;
      }else if(_listDatas[i].indexLetter == _listDatas[i-1].indexLetter){ //不包含头部的cell
        groupOffSet += 54;
      }else{
        _groupOffsetMap.addAll({_listDatas[i].indexLetter:groupOffSet}); //包含头部的cell
        groupOffSet += 84;
      }
    }

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _itemForRow(BuildContext context, int index){
    if (index < _headerList.length) {
      return _headerList[index];
    }

    if (index > 4 && _listDatas[index-4].indexLetter == _listDatas[index-5].indexLetter){
      return _FriendsCell(
        imageUrl: _listDatas[index-4].imageUrl,
        name: _listDatas[index-4].name,
      );
    }

    return _FriendsCell(
      imageUrl: _listDatas[index-4].imageUrl,
      name: _listDatas[index-4].name,
      groupTitle: _listDatas[index-4].indexLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('通讯录'),
        backgroundColor: weChatThemeColor,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: weChatThemeColor,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _headerList.length + _listDatas.length,
              itemBuilder: _itemForRow,
            )
          ),
          IndexBar(
            indexBarCallBack: (String str){
              print('object---$str');
              if(_groupOffsetMap[str] != null) {
                _scrollController.animateTo(
                  _groupOffsetMap[str],
                  duration: Duration(milliseconds: 10),
                  curve: Curves.easeIn
                );
              }
              
            },
          )
        ],
      )
    );
  }

  
}

class _FriendsCell extends StatelessWidget {

  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imgAssets;

  _FriendsCell({
    this.imageUrl,
    this.name,
    this.groupTitle,
    this.imgAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: groupTitle != null ? 30 : 0,
            color: weChatThemeColor,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            child: Text(groupTitle != null ? groupTitle : '', style: TextStyle(
              fontSize: 14,
              color: Colors.grey
            ),),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: 
                      imageUrl != null ? 
                      NetworkImage(imageUrl) : 
                      AssetImage(imgAssets)),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth(context) - 54,
                        height: 53.5,
                        alignment: Alignment.centerLeft,
                        child: Text(name, style: TextStyle(
                          fontSize: 16,
                        ),)
                      ),
                      Container(
                        color: weChatThemeColor,
                        height: 0.5,
                        width: screenWidth(context) - 54,
                      ),
                    ],
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}