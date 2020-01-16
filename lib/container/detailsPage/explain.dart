import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Explain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        width: ScreenUtil().setWidth(828),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          '说明：> 急速送达 > 正品保证',
          style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(30)),
        ));
  }
}
