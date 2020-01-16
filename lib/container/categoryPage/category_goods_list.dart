import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provide/provide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../../provide/category_goods_list.dart';
import '../../provide/child_category.dart';
import '../../service/service_method.dart';
import '../../model/categoryGoodsList.dart';
import '../../router/application.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategoryProvide>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：${e}');
        }

        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(621),
              child: EasyRefresh(
                footer: ClassicalFooter(
                  loadingText: '加载中...',
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  showInfo: false,
                  loadedText:
                      Provide.value<ChildCategoryProvide>(context).loadedText,
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index) {
                    return _listWidget(data.goodsList, index);
                  },
                ),
                onLoad: () async {
                  getMoreGoodsList();
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

  void getMoreGoodsList() {
    Provide.value<ChildCategoryProvide>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId': Provide.value<ChildCategoryProvide>(context).subId,
      'page': Provide.value<ChildCategoryProvide>(context).page
    };
    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        // Provide.value<ChildCategoryProvide>(context).changeNoMoreText('没有更多了');
        setState(() {
          Provide.value<ChildCategoryProvide>(context)
              .changeLoadedText('没有更多了');
        });
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .addGoodsList(goodsList.data);
      }
    });
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

  Widget _listWidget(List<Data> goodsList, int index) {
    return InkWell(
      onTap: () {
        print(json.encode(goodsList[index]));
        // String goodId = goodsList[index]['goodsId'];
        // Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
      },
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
