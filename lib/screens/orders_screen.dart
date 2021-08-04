import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/orderUI.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return OrderUI(orderData.orders[index]);
          },
          itemCount: orderData.orders.length,
        ),
      ),
    );
  }
}
