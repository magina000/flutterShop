import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../model/category.dart';
import '../provide/child_category.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List categoryList = [];

  @override
  void initState() {
    getCategory();
    super.initState();
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
    });
  }

  Widget _leftInkwellWidget(int index) {
    return InkWell(
      onTap: () {
        var childList = categoryList[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(categoryList[index].mallCategoryName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      ),
    );
  }
}
