import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
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
        SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          child: ListTile(
            title: Text('My Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
        )
      ]),
    );
  }
}