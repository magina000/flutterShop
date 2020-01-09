import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/childCategory.dart';
import '../model/categoryGoodsList.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List categoryList = [];
  var listIndex = 0; //索引

  @override
  void initState() {
    getCategory();
    // getGoodList();
    super.initState();
    print('222222');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(207),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return _leftInkwellWidget(index);
        },
      ),
    );
  }

  void getCategory() async {
    await request('getCategory').then((resp) {
      var data = json.decode(resp.toString());
      CategoryListModel listModel = CategoryListModel.fromJson(data);
      setState(() {
        categoryList = listModel.data;
      });

      Provide.value<ChildCategoryProvide>(context).getChildCategory(
          categoryList[0].bxMallSubDto, categoryList[0].mallCategoryId);
      getGoodList();
    });
  }

  void getGoodList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': "",
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

  Widget _leftInkwellWidget(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = categoryList[index].bxMallSubDto;
        var categoryId = categoryList[index].mallCategoryId;
        Provide.value<ChildCategoryProvide>(context)
            .getChildCategory(childList, categoryId);
        getGoodList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 15),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(categoryList[index].mallCategoryName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      ),
    );
  }
}
