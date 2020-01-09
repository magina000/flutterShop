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
  // PageController pageController;
  final pageController = PageController();
  //页面数组
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex = 0; //当前页序号
  // var currentPage; //当前页面
  //初始化
  // @override
  // void initState() {
  //   currentPage = tabBodies[currentIndex];
  //   super.initState();
  // }

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
      /**
       * 保持页面状态
       * 可以直接用IndexedStack实现，但是当应用第一次加载的时候，所有子页状态都会被实例化
       * 通过PageView/TabBarView和AutomaticKeepAliveClientMixin实现
       */
      // body: currentPage,
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: tabBodies,
      // ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: tabBodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        items: bottomTabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          // setState(() {
          //   currentIndex = index;
          //   currentPage = tabBodies[currentIndex];
          // });
          pageController.jumpToPage(index);
        },
      ),
    );
  }
}
