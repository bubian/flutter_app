import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new AppHomeState();
  }
}

class AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {

  TabController _controller;
  int _selectedIndex = 1;

  static List tabData = [
    {'text': '工作室', 'icon': Image(image:AssetImage("assets/images/home/main_tab_handpick_normal.webp"),width: 20,height: 20,)},
    {'text': '患者', 'icon':  Image.asset("assets/images/home/main_tab_hospital_normal.webp",width: 20,height: 20,)},
    {'text': '学术圈', 'icon': Image.asset("assets/images/home/main_tab_msg_normal.webp",width: 20,height: 20,)},
    {'text': '我的', 'icon': Image.asset("assets/images/home/main_tab_mine_normal.webp",width: 20,height: 20,)}
  ];

  List<Widget> myTabs = [];


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabData.length, vsync: this);
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(child: Text(
          tabData[i]['text'],
          style: TextStyle(
            fontSize: 12
          ),
      ), icon: tabData[i]['icon']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: TabBarView(
        controller: _controller,
        children: tabData.map((e){
          return Container(
            alignment: Alignment.center,
            child: Text(e['text'],textScaleFactor: 5,),
          );
        }).toList(),
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            height: 76.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 0.5,
                  padding:EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  color: Color(0xFF8E8E8E),
                ),
                TabBar(
                    controller: _controller,
                    indicator: const BoxDecoration(),
                    indicatorColor: Theme.of(context).primaryColor, //tab标签的下划线颜色
                    // labelColor: const Color(0xFF000000),
                    labelColor: Colors.blue,
                    unselectedLabelColor: const Color(0xFFE2E7F1),
                    tabs: myTabs
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}