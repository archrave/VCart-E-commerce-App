import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text(
                'Options',
                style: TextStyle(fontSize: 20),
              )),
          ListTile(
            title: Text(
              'My Orders',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            title: Text('Manage products', style: TextStyle(fontSize: 15)),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
