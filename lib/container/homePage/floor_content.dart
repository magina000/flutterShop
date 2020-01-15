import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRowWidget(), _secondRowWidget()],
      ),
    );
  }

  Widget _firstRowWidget() {
    return Row(
      children: <Widget>[
        _goodsWidget(floorGoodsList[0]),
        Column(children: <Widget>[
          _goodsWidget(floorGoodsList[1]),
          _goodsWidget(floorGoodsList[2]),
        ]),
      ],
    );
  }

  Widget _secondRowWidget() {
    return Row(
      children: <Widget>[
        _goodsWidget(floorGoodsList[3]),
        _goodsWidget(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsWidget(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(414),
      child: InkWell(
        child: Image.network(goods['image']),
      ),
    );
  }
}
