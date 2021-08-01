import 'package:flutter/material.dart';
import './screens/products_screen.dart';

void main() {
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
        primaryColor: Color(0xFF785bcf),
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductsScreen(),
    );
  }
}
