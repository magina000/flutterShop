import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/goods_detail.dart';

class HtmlText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<GoodsDetailProvide>(context).goodsDetail.data.goodInfo;
    return Provide<GoodsDetailProvide>(
      builder: (context, child, data) {
        var isLeft = Provide.value<GoodsDetailProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(data: goodsInfo.goodsDetail),
          );
        } else {
          return Container(
              width: ScreenUtil().setWidth(828),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text('暂时没有数据'));
        }
      },
    );
  }
}
