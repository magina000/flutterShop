import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import '../model/cartGoods.dart';
import '../container/cartPage/cart_item.dart';
import '../container/cartPage/bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: getCartInfo(context),
        builder: (context, snapshot) {
          List<CartGoods> cartGoodsList =
              Provide.value<CartProvide>(context).cartGoodsList;
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ListView.builder(
                    itemCount: cartGoodsList.length,
                    itemBuilder: (context, index) {
                      return CartItem(cartGoods: cartGoodsList[index]);
                    }),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Bottom(),
                )
              ],
            );
          } else {
            return Text('加载中...');
          }
        },
      ),
    );
  }

  Future getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartGoodsList();
    return true;
  }
}
