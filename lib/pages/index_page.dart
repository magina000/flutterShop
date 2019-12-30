import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'catergory_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //页面数组
  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex = 0;  //当前页序号
  var currentPage;  //当前页面
  //初始化
  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  //底部栏
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        items: bottomTabs,
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
    );
  }
}