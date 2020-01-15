import 'package:flutter/material.dart';
import '../model/goodsDetail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailModel goodsDetail;

  getGoodsDetail(String goodsId) {
    var formData = {'goodId': goodsId};
    request('getGoodDetailById', formData: formData).then((val) {
      var data = json.decode(val.toString());
      goodsDetail = GoodsDetailModel.fromJson(data);
      notifyListeners();
    });
  }
}
