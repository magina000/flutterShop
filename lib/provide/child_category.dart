import 'package:flutter/material.dart';
import '../model/childCategory.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = []; //商品列表
  int childIndex = 0; //子类索引值
  String categoryId = '4'; //大类ID
  String subId = ''; //小类ID

  int page = 1; //列表页数
  String loadedText = ''; //下拉加载状态提示

  getChildCategory(List<BxMallSubDto> list, String id) {
    childIndex = 0;
    categoryId = id;
    subId = ''; //点击大类时，把子类ID清空

    page = 1;//切换为第一页
    loadedText = '';

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
  changeChildIndex(int index, String id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //下拉页面增加
  addPage() {
    page++;
  }

  changeLoadedText(String text){
    loadedText = text;
    notifyListeners();
  }
}
