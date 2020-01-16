import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/application.dart';

class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRowWidget(context), _secondRowWidget(context)],
      ),
    );
  }

  Widget _firstRowWidget(context) {
    return Row(
      children: <Widget>[
        _goodsWidget(context, floorGoodsList[0]),
        Column(children: <Widget>[
          _goodsWidget(context, floorGoodsList[1]),
          _goodsWidget(context, floorGoodsList[2]),
        ]),
      ],
    );
  }

  Widget _secondRowWidget(context) {
    return Row(
      children: <Widget>[
        _goodsWidget(context, floorGoodsList[3]),
        _goodsWidget(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsWidget(BuildContext context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(414),
      child: InkWell(
        child: Image.network(goods['image']),
        onTap: () {
          Application.router
              .navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
      ),
    );
  }
}
