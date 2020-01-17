import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartGoods.dart';
import './count.dart';

class CartItem extends StatelessWidget {
  final CartGoods cartGoods;
  const CartItem({Key key, this.cartGoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _checkBtn(cartGoods),
          _goodsImage(cartGoods),
          _goodsName(cartGoods),
          _goodsPrice(cartGoods)
        ],
      ),
    );
  }

  //多选按钮
  Widget _checkBtn(CartGoods item) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  //商品图片
  Widget _goodsImage(CartGoods item) {
    return Container(
      width: ScreenUtil().setWidth(200),
      padding: EdgeInsets.all(5.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _goodsName(CartGoods item) {
    return Container(
      width: ScreenUtil().setWidth(320),
      padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(item.goodsName), Count()],
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(CartGoods item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
