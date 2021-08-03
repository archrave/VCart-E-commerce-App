import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import '../screens/cart_screen.dart';
import './screens/products_screen.dart';
import './screens/product_detail_screen.dart';

void main() {
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // This provider widget is added to main.dart because we want this widget to be attached to the topmost widget in the tree

    return MultiProvider(
      // Following is the most commonly used provider, it allows us to listen to a class, and whenever that class updates, it rebuilds only those widgets which were listening to the data.
      // .value approach isn't good here since we're creating a BRAND new instance of this Products() class
      providers: [
        //create: instead of builder: in provider v5.0

        /* This create:/builder: method below basically provides the SAME instance to all the widget below this wiget tree
          which means the same Object of the 'Providers' class, through which we can acces the same 'item' list  */

        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF785bcf),
          accentColor: Color(0xFFe6505d),
          fontFamily: 'Lato',
        ),
        home: ProductsScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
