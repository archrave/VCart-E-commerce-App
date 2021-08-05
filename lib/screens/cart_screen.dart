import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/CartUI.dart';

class CartScreen extends StatelessWidget {
  static const routeName = './cart-screen';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:  ',
                    style: TextStyle(fontSize: 20),
                  ),
                  //Takes all the available space in between and reserves for itself
                  Chip(
                    label: Text(
                      '₹${cartData.sumTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrders(
                          cartData.items.values.toList(), cartData.sumTotal);
                      cartData.clear();
                    },
                    child: Text('Place Order'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) {
              return CartUI(
                id: cartData.items.values.toList()[i].id,
                productId: cartData.items.keys.toList()[i],
                title: cartData.items.values.toList()[i].title,
                price: cartData.items.values.toList()[i].price,
                quantity: cartData.items.values.toList()[i].quantity,
              );
            },
            itemCount: cartData.cartLength,
          ))
        ],
      ),
    );
  }
}
