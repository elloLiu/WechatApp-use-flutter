import 'package:WECHATAPP_USE_FLUTTER/pages/discover/discover_detail_page.dart';
import 'package:flutter/material.dart';

class DiscoverCell extends StatefulWidget {

  final String title;
  final String imgName;
  final String subTitle;
  final String subImgName;

  const DiscoverCell({ //const ：之前为构造函数，之后为构造器
    Key key, 
    @required this.title, 
    @required this.imgName, 
    this.subTitle, 
    this.subImgName,
  }) : assert(title != null, 'title 不能为空'),
        assert(imgName != null, 'imgName 不能为空'); //断言,运行的时候如果没有直接报错
  
  @override
  State<StatefulWidget> createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {

  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            // builder: (BuildContext context){
            //   return DiscoverDatailPage(title: title,);
            // } 两个方法==
            builder: (BuildContext context) => DiscoverDatailPage(title: widget.title,)
            
          )
        );
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails downDetails){
        setState(() {
          _currentColor = Colors.grey;
        });
      },
      onTapCancel: (){
        setState(() {
          _currentColor = Colors.white;
        });
      },

      child: Container(
      color: _currentColor,
      height: 54,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Image(image: AssetImage(widget.imgName),width: 20,),
                SizedBox(width: 15,),
                Text(widget.title),
              ],
            ),
          ),//left
          Container(
            child: Row(
              children: <Widget>[
                Text(widget.subTitle != null ? widget.subTitle : '',
                  style: TextStyle(
                    color: Colors.grey
                  ),),
                widget.subImgName != null 
                  ? Container(child: Image(image: AssetImage(widget.subImgName),width: 15,), margin: EdgeInsets.only(left: 10, right: 10),)
                  : Container(),
                Image(image: AssetImage('images/icon_right.png'),width: 15,),
              ],
            ),
          ), //Right
        ],
      ),
    ),
    );
  }
}