import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/goods_detail.dart';
import '../../model/cartGoods.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<GoodsDetailProvide>(context).goodsDetail.data.goodInfo;
    CartGoods cartGoods = CartGoods.fromJson({
      'goodsId': goodsInfo.goodsId,
      'goodsName': goodsInfo.goodsName,
      'count': 1,
      'price': goodsInfo.presentPrice,
      'images': goodsInfo.image1
    });
    return Container(
      width: ScreenUtil().setWidth(828),
      color: Colors.white,
      height: ScreenUtil().setHeight(155),
      padding: EdgeInsets.only(bottom: 35),
      child: Row(
        children: <Widget>[
          _cartImage(),
          _addToCart(context, cartGoods),
          _buy(context)
        ],
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

  Widget _addToCart(BuildContext context, CartGoods cartGoods) {
    return InkWell(
      onTap: () async {
        await Provide.value<CartProvide>(context).save(cartGoods);
      },
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

  Widget _buy(context) {
    return InkWell(
      onTap: () async {
        await Provide.value<CartProvide>(context).remove();
      },
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
