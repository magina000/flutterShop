import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail.dart';

class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, data) {
        var isLeft = Provide.value<GoodsDetailProvide>(context).isLeft;
        var isRight = Provide.value<GoodsDetailProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _tabBarLeft(context, isLeft),
                  _tabBarRight(context, isRight)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
        width: ScreenUtil().setWidth(414),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text('详情',
            style: TextStyle(color: isLeft ? Colors.pink : Colors.black)),
      ),
    );
  }

  Widget _tabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
        width: ScreenUtil().setWidth(414),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.black12))),
        child: Text('评论',
            style: TextStyle(color: isRight ? Colors.pink : Colors.black)),
      ),
    );
  }
}
