import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List categoryGoodsList = [];

  @override
  void initState() {
    // getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: ScreenUtil().setWidth(621),
        child: ListView.builder(
          itemCount: categoryGoodsList.length,
          itemBuilder: (context, index){
            return _listWidget(index);
          },
        ),
      ),
    );
  }

  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(250),
      child: Image.network(categoryGoodsList[index].image),
    );
  }

  Widget _goodsName(index) {
    return Container(
      width: ScreenUtil().setWidth(371),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        categoryGoodsList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
        width: ScreenUtil().setWidth(371),
        margin: EdgeInsets.only(top: 20.0),
        child: Row(children: <Widget>[
          Text(
            '价格:￥${categoryGoodsList[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${categoryGoodsList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ]));
  }

  Widget _listWidget(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      ),
    );
  }
}
