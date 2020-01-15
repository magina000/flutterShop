import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/goods_detail.dart';
import '../container/detailsPage/top_area.dart';
import 'dart:convert';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getGoodsDetail(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: getGoodsDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                child: Row(
              children: <Widget>[TopArea()],
            ));
          } else {
            return Text('加载中........');
          }
        },
      ),
    );
  }

  Future getGoodsDetail(BuildContext context) async {
    await Provide.value<GoodsDetailProvide>(context).getGoodsDetail(goodsId);
    return true;
  }
}
