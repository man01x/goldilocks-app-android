import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/cart_controller.dart';
import '../models/restaurant.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class StoreShoppingCartFloatButtonWidget extends StatefulWidget {
  const StoreShoppingCartFloatButtonWidget({
    this.iconColor,
    this.labelColor,
    this.restaurant,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;
  final Restaurant restaurant;

  @override
  _StoreShoppingCartFloatButtonWidget createState() => _StoreShoppingCartFloatButtonWidget();
}

class _StoreShoppingCartFloatButtonWidget extends StateMVC<StoreShoppingCartFloatButtonWidget> {
  CartController _con;

  _StoreShoppingCartFloatButtonWidget() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        color: Theme.of(context).accentColor,
        shape: StadiumBorder(),
        onPressed: () {
          if (currentUser.value.apiToken != null) {
            Navigator.of(context).pushNamed('/Cart', arguments: RouteArgument(param: '/Details', id: widget.restaurant.id));
          } else {
            Navigator.of(context).pushNamed('/Login');
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            SvgPicture.asset(
                'assets/custom_img/cart_icon.svg',
                width: 30),
            Container(
              child: AutoSizeText(
                _con.cartCount.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.merge(
                  TextStyle(color: Theme.of(context).hintColor, fontSize: 9),
                ),
              ),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
              constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
            ),
          ],
        ),
      ),
    );
  }
}
