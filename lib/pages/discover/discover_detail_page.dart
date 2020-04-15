import 'package:flutter/material.dart';

class DiscoverDatailPage extends StatefulWidget {

  final String title;
  const DiscoverDatailPage({Key key, this.title}) : super(key: key);
  
  @override
  _DiscoverDatailPageState createState() => _DiscoverDatailPageState();
}

class _DiscoverDatailPageState extends State<DiscoverDatailPage>
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
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}