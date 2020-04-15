// import 'dart:math';

import 'package:flutter/material.dart';

import '../../const.dart';

const INDEX_WORDS = ['🔍','⭐️','A','B','C','D','E','F','G','H','I','J','K','L',
                      'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
class IndexBar extends StatefulWidget {

  final void Function(String str) indexBarCallBack;
  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _IndexBarState createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Color _bgColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;
  var _selectedIndex = -1;

  var _indicatorY = 0.0;
  var _indicatorText = 'A';
  var _isIdtHidden = true;

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

  int getIndexStr(BuildContext context, Offset globalPosition) {
    RenderBox box = context.findRenderObject();
    double y = box.globalToLocal(globalPosition).dy;
    var itemH = screenHeight(context)/2/INDEX_WORDS.length;
    int index = (y ~/ itemH).clamp(0, INDEX_WORDS.length-1);
    print(INDEX_WORDS[index]);
    return index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for(int i = 0; i < INDEX_WORDS.length ; i++){
      words.add(Expanded(child: Text(INDEX_WORDS[i],style: TextStyle(
        fontSize: 10,
        color: _textColor
      ),),));
    }
    
    return Positioned(
      right: 0.0,
      width: 120,
      top: screenHeight(context)/8,
      height: screenHeight(context)/2,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            alignment: Alignment(0, _indicatorY),
            child: _isIdtHidden == true ? null : Stack(
              alignment: Alignment(-0.2, 0),
              children: <Widget>[
                Image(image: AssetImage('images/qp.png'),width: 60,),
                Text(_indicatorText, style:TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
                ))
              ],
            ),
          )
             ,
          GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details){
              int index = getIndexStr(context, details.globalPosition);
              if (index != _selectedIndex){
                _selectedIndex = index;
                widget.indexBarCallBack(INDEX_WORDS[_selectedIndex]);
              }

              _indicatorText = INDEX_WORDS[_selectedIndex];
              _indicatorY = 2.2 / (INDEX_WORDS.length-1) * index - 1.1;
              _isIdtHidden = false;
              setState(() {});
              
            },
            onVerticalDragDown: (DragDownDetails details){
              int index = getIndexStr(context, details.globalPosition);
              if (index != _selectedIndex){
                _selectedIndex = index;
                widget.indexBarCallBack(INDEX_WORDS[_selectedIndex]);
              }

              _bgColor = Color.fromRGBO(1, 1, 1, 0.3);
              _textColor = Colors.white;
              _isIdtHidden = false;
              setState(() {});
            },
            onVerticalDragEnd: (DragEndDetails details){
              _bgColor = Color.fromRGBO(1, 1, 1, 0.0);
              _textColor = Colors.black;
              _selectedIndex = -1;
              _isIdtHidden = true;
              setState(() {});
            },
            child: Container(
              width: 20,
              color: _bgColor,
              child: Column(
                children: words,
              ),
            ),
          )
        
        ],
      )
    );
  }
  }