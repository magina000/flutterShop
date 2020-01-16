import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/goods_detail.dart';
import '../container/detailsPage/top_area.dart';
import '../container/detailsPage/explain.dart';
import '../container/detailsPage/tab_bar.dart';
import '../container/detailsPage/html_text.dart';
import '../container/detailsPage/bottom.dart';

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
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    TopArea(),
                    Explain(),
                    MyTabBar(),
                    HtmlText()
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Bottom(),
                )
              ],
            );
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
