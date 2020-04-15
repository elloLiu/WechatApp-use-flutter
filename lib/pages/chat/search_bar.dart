import 'package:WECHATAPP_USE_FLUTTER/const.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/chat.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/search_page.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/friends/friend_data.dart';
import 'package:flutter/material.dart';

class SearchCell extends StatefulWidget {

  final List<Chat> datas;
  const SearchCell({Key key, this.datas}) : super(key: key);

  @override
  _SearchCellState createState() => _SearchCellState();
}

class _SearchCellState extends State<SearchCell>
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
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => SearchPage(datas: widget.datas,)
          )
        );
      },
      child: Container(
        height: 44,
        padding: EdgeInsets.all(5),
        color: weChatThemeColor,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ), //白底
            Container(
              height: 34,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage('images/searchB.png'), width: 15, color: Colors.grey,),
                  Text('  搜索', style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey
                  ))
                ],
              )
            ),
          ],
        )
      )
    );
  }
}



class SearchBar extends StatefulWidget {

/*
 * 在没事实现 
 * onChanged: (String text){
            print('$text');
          }
          这个回调的时候
          在 widget.onChanged(text) 处会出错，下边的代码不执行
 */
  final ValueChanged<String> onChanged;
  const SearchBar({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final TextEditingController _control = TextEditingController();
  bool _showClear = false;


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

  _onChange(String text){
   
    widget.onChanged(text);
    _showClear = (text.length > 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      color: weChatThemeColor,
      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Container(
            height: 44,
            child: Row(
              children: <Widget>[
                Container(
                  height: 35,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(left:5, right:5),
                  width: screenWidth(context) - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage('images/searchB.png'), width: 20,color: Colors.grey,),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          onChanged: _onChange,
                          controller: _control,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 5,top: -15),
                            hintText: '搜索',
                          ),
                        ),
                      ),
                      _showClear ? GestureDetector(
                        onTap: (){
                          _control.clear();
                          _onChange('');
                        },
                        child: Icon(Icons.cancel, size: 20, color: Colors.grey),
                      ) : Container()
                      
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text('取消'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
