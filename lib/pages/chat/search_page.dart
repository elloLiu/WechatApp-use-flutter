import 'package:WECHATAPP_USE_FLUTTER/const.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/chat.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/search_bar.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {

  final List<Chat> datas;
  const SearchPage({Key key, this.datas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Chat> _model = [];
  String _searchT = '';

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

  void _searchText(String text){
    print('$text');
    if (text == '') {
      _model = [];
    }else{
      _model.clear();
      for (var chat in widget.datas) {
        if (chat.name.contains(text)) {
          _model.add(chat);
        }
      }
    }
    _searchT = text;
    setState(() {});
  }

  Widget _styleText(String name){
    TextStyle normal = TextStyle(fontSize: 16, color: Colors.black);
    TextStyle highlight = TextStyle(fontSize: 16, color: Colors.green);

    List<TextSpan> spans = [];
    List<String> strs = name.split(_searchT);
    for (int i = 0; i < strs.length; i++) {
      if (strs[i] == '' && i < strs.length -1) {
        spans.add(TextSpan(text: _searchT, style: highlight));
      }else{
        spans.add(TextSpan(text: strs[i], style: normal));
        if (i < strs.length-1) {
          spans.add(TextSpan(text: _searchT, style: highlight));
        }
      }
    }
    return RichText(text: TextSpan(children: spans));
  }

  Widget _itemForRow(BuildContext context, int index) {
    return ListTile(
      title: _styleText(_model[index].name),
      subtitle: Container(
        width: 20,
        height: 20,
        child: Text(_model[index].message, overflow: TextOverflow.ellipsis,),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_model[index].imageUrl),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(onChanged: (String text) => _searchText(text)) ,
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context, 
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ListView.builder(
                  itemCount: _model.length,
                  itemBuilder: _itemForRow,
                ),
              )
            )
          )
        ],
      ),
    );
  }               
                    
}



