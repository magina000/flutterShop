import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  PageController pageController;
  //页面数组
  final List<Widget> tabBodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];
  int currentIndex = 0; //当前页序号
  var currentPage; //当前页面
  //初始化
  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    pageController = new PageController()
      ..addListener(() {
        if (currentPage != pageController.page.round()) {
          setState(() {
            currentPage = pageController.page.round();
          });
        }
      });
    super.initState();
  }

  //底部栏
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心'))
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 828, height: 1792)..init(context);
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
      // body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        items: bottomTabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
    );
  }
}
