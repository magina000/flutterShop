import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import './router/route.dart';
import './router/application.dart';
import 'pages/index_page.dart';
import 'provide/child_category.dart';
import 'provide/category_goods_list.dart';
import 'provide/goods_detail.dart';

void main() {
  var childCategoryProvide = ChildCategoryProvide();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var goodsDetailProvide = GoodsDetailProvide();

  var providers = Providers();
  providers
    ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(
        Provider<GoodsDetailProvide>.value(goodsDetailProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //注入配置的route
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage());
  }
}
