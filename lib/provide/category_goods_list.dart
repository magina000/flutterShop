import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsListModel> goodsList = [];

  //点击大类时更换商品列表
  getGoodsList(List list) {
    goodsList = list;
    notifyListeners();
  }
}
