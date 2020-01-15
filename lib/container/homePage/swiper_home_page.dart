import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/application.dart';

// 首页轮播组件
class SwiperHomePage extends StatelessWidget {
  final swiperDataList;
  SwiperHomePage({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(828),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            swiperDataList[index]['image'],
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        onTap: (index){
          Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
        },
      ),
    );
  }
}
