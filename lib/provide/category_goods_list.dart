import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<Data> goodsList = [];
  //点击大类时更换商品列表
  getGoodsList(List<Data> list) {
    goodsList = list;
    notifyListeners();
  }

  //下拉刷新增加商品列表
  addGoodsList(List<Data> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
