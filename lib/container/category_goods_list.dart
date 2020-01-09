import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/category_goods_list.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(621),
              child: ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(data.goodsList, index);
                },
              ),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('暂时没有所属商品'),
          );
        }
      },
    );
  }

  Widget _goodsImage(goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(250),
      child: Image.network(goodsList[index].image),
    );
  }

  Widget _goodsName(goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(371),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        goodsList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(goodsList, index) {
    return Container(
        width: ScreenUtil().setWidth(371),
        margin: EdgeInsets.only(top: 20.0),
        child: Row(children: <Widget>[
          Text(
            '价格:￥${goodsList[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${goodsList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ]));
  }

  Widget _listWidget(goodsList, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(goodsList, index),
            Column(
              children: <Widget>[
                _goodsName(goodsList, index),
                _goodsPrice(goodsList, index)
              ],
            )
          ],
        ),
      ),
    );
  }
}
