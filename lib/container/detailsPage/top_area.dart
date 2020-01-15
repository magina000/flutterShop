import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail.dart';

class TopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, data) {
        var goodsInfo = Provide.value<GoodsDetailProvide>(context)
            .goodsDetail
            .data
            .goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('正在加载中......');
        }
      },
    );
  }

  //商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(800),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(788),
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(35)),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(788),
      padding: EdgeInsets.only(left: 20.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(788),
      padding: EdgeInsets.only(left: 20.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Text(
            '市场价:￥${oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
