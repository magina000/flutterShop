import 'package:flutter/material.dart';
import '../model/goodsDetail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailModel goodsDetail;

  bool isLeft = true;
  bool isRight = false;

  getGoodsDetail(String goodsId) async{
    var formData = {'goodId': goodsId};
    await request('getGoodDetailById', formData: formData).then((val) {
      var data = json.decode(val.toString());
      goodsDetail = GoodsDetailModel.fromJson(data);
      notifyListeners();
    });
  }

  //改变tabBar的状态
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
