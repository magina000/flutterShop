import 'package:flutter/material.dart';
import '../model/childCategory.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';

  getChildCategory(List<BxMallSubDto> list, String id) {
    childIndex = 0;
    categoryId = id;
    /**补充全部类别 */
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    //通知监听者刷新。
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}
