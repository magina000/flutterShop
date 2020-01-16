import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(828),
      color: Colors.white,
      height: ScreenUtil().setHeight(155),
      padding: EdgeInsets.only(bottom: 35),
      child: Row(
        children: <Widget>[_cartImage(), _addToCart(), _buy()],
      ),
    );
  }

  Widget _cartImage() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(128),
        alignment: Alignment.center,
        child: Icon(
          Icons.shopping_cart,
          size: 35,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _addToCart() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(350),
        height: ScreenUtil().setHeight(120),
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          '加入购物车',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.white),
        ),
      ),
    );
  }

  Widget _buy() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(350),
        height: ScreenUtil().setHeight(120),
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          '马上购买',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.white),
        ),
      ),
    );
  }
}
