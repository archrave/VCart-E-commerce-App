import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/orderUI.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: orderData.orders.isNotEmpty
          ? (_isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return OrderUI(orderData.orders[index]);
                    },
                    itemCount: orderData.orders.length,
                  ),
                ))
          : Center(
              child: Text(
                'Your Orders are empty. Try buying some products!',
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
    );
  }
}
