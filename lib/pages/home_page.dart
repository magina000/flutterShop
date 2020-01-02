import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../container/swiper_home_page.dart';
import '../container/top_navigator.dart';
import '../container/ad_banner.dart';
import '../container/leader_phone.dart';
import '../container/recommend_list.dart';
import '../container/floor_title.dart';
import '../container/floor_content.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  void initState() {
    getHotGoods();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          future: request('homePageContent',
              formData: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast(); //轮播图
              List<Map> topNavigatorList =
                  (data['data']['category'] as List).cast(); //导航区
              String advertesPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
              String leaderImage =
                  data['data']['shopInfo']['leaderImage']; //店长图片
              String leaderPhone =
                  data['data']['shopInfo']['leaderPhone']; //店长电话
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast(); // 商品推荐
              String floor1Title =
                  data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor2Title =
                  data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层2的标题图片
              String floor3Title =
                  data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层3的标题图片
              List<Map> floor1 =
                  (data['data']['floor1'] as List).cast(); //楼层1商品和图片
              List<Map> floor2 =
                  (data['data']['floor2'] as List).cast(); //楼层2商品和图片
              List<Map> floor3 =
                  (data['data']['floor3'] as List).cast(); //楼层3商品和图片

              return EasyRefresh(
                footer: ClassicalFooter(
                  loadingText: '上拉加载',
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  infoText: '加载中...',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperHomePage(swiperDataList: swiperDataList),
                    TopNavigator(topNavigatorList: topNavigatorList),
                    AdBanner(advertesPicture: advertesPicture),
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leaderPhone),
                    RecommendList(recommendList: recommendList),
                    FloorTitle(pictureAddress: floor1Title),
                    FloorContent(floorGoodsList: floor1),
                    FloorTitle(pictureAddress: floor2Title),
                    FloorContent(floorGoodsList: floor2),
                    FloorTitle(pictureAddress: floor3Title),
                    FloorContent(floorGoodsList: floor3),
                    _hotGoodsWidget(),
                  ],
                ),
                onLoad: () async {
                  var formPage = {'page': page};
                  await request('homePageBelowConten', formData: formPage)
                      .then((resp) {
                    var data = json.decode(resp.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }

  void getHotGoods() {
    request('homePageBelowConten', formData: page).then((resp) {
      var data = json.decode(resp.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

//火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(10.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length > 0) {
      List<Widget> listWidget = hotGoodsList.map((goods) {
        return InkWell(
          onTap: () {
            print('点击了火爆商品');
          },
          child: Container(
            width: ScreenUtil().setWidth(411),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  goods['image'],
                  width: ScreenUtil().setWidth(411),
                ),
                Text(
                  goods['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('￥${goods['mallPrice']}'),
                    Text(
                      '￥${goods['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }

  Widget _hotGoodsWidget() {
    return Container(
      child: Column(children: <Widget>[
        hotTitle,
        _wrapList(),
      ]),
    );
  }
}
