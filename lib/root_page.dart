import 'package:WECHATAPP_USE_FLUTTER/pages/discover/discover_page.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/friends/friend_page.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/mine_page.dart';
import 'package:WECHATAPP_USE_FLUTTER/pages/chat/wechat_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
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

/*
 * begin 
 */

  int _currentIndex = 0;
  final PageController _pageControl = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            _currentIndex = index;
            setState(() {});
            _pageControl.jumpToPage(index);
          },
          selectedFontSize: 12.0,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_chat.png')),
              activeIcon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_chat_hl.png')),
              title: Text('微信')
            ),
            BottomNavigationBarItem(
              icon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_friends.png')),
              activeIcon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_friends_hl.png')),
              title: Text('通讯录')
            ),
            BottomNavigationBarItem(
              icon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_discover.png')),
              activeIcon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_discover_hl.png')),
              title: Text('发现')
            ),
            BottomNavigationBarItem(
              icon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_mine.png')),
              activeIcon: Image(height: 20, width: 20, image: AssetImage('images/tabbar_mine_hl.png')),
              title: Text('我')
            )
          ],
        ),
        body: PageView(
          // onPageChanged: (int index){
          //   _currentIndex = index;
          //   setState(() {});
          // },滑动切换页面
          physics: NeverScrollableScrollPhysics(),
          controller: _pageControl,
          children: <Widget>[
            WeChatPage(), 
            FriendPage(), 
            DiscoverPage(), 
            MinePage(),
          ],
        ),
      ),
    );
  }
}