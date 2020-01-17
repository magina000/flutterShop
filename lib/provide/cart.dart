import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartGoods.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartGoods> cartGoodsList = [];

  save(CartGoods goods) async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //初始化SharedPreferences
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值将字符串decode
    List cartGoodsJson = cartString == null ? [] : json.decode(cartString);
    //把获得值转变成List<CartGoods>
    cartGoodsList =
        cartGoodsJson.map((m) => new CartGoods.fromJson(m)).toList();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave = false; //默认没有
    //进行循环，找出是否已经存在该商品
    for (var i = 0; i < cartGoodsList.length; i++) {
      if (cartGoodsList[i].goodsId == goods.goodsId) {
        cartGoodsList[i].count++;
        isHave = true;
      }
    }
    //  如果没有，进行增加
    if (!isHave) {
      cartGoodsList.add(goods);
    }
    //把数组对象encode转化为字符串
    cartString = json.encode(cartGoodsList).toString();
    // print(cartString);
    prefs.setString('cartInfo', cartString); //进行持久化
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    print('清空完成-----------------');
    notifyListeners();
  }

  getCartGoodsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值将字符串decode
    List cartGoodsJson = cartString == null ? [] : json.decode(cartString);
    //把获得值转变成List<CartGoods>
    cartGoodsList = cartGoodsJson.map((m) => new CartGoods.fromJson(m)).toList();
    notifyListeners();
  }
}
