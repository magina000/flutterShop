import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import '../model/childCategory.dart';
import '../model/categoryGoodsList.dart';
import '../service/service_method.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<ChildCategoryProvide>(
        builder: (context, child, childCategory) {
          return Container(
            height: ScreenUtil().setHeight(100),
            width: ScreenUtil().setWidth(621),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12)),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWellWidget(
                    index, childCategory.childCategoryList[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void getGoodList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel categoryGoodsModel =
          CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsModel.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(categoryGoodsModel.data);
      }
    });
  }

  Widget _rightInkWellWidget(int index, BxMallSubDto item) {
    bool isCheck = false;
    isCheck = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategoryProvide>(context).changeChildIndex(index);
        getGoodList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isCheck ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
