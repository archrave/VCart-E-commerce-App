import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_loading_screen.dart';

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
        // create: instead of builder: in provider v5.0

        /* This create:/builder: method below basically provides the SAME instance to all the widgets below this widget tree
          which means the same Object of the 'Providers' class, through which we can access the same 'items' list  */

        /* We have to make sure that Auth provider is declared at the top, so that the proxyprovider (products) can depend on it. */
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          //  2nd arg. is the above Auth object, and the 3rd one is the previous Products() object
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF785bcf),
            accentColor: Color(0xFFe6505d),
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),

                  // Below we're checking if the connection state is waiting or not, if so, then we are displaying a loading text
                  // One might think that we should have another if check after this should be done that whether we recieve correct login data or not, but
                  // When the tryAutologin function runs it calls notifyListeners which makes the Consumer rebuild, then it checks whether auth.isAuth or not
                  // which by then will be decided.
                  builder: (nctx, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashLoadingScreen()
                          :
                          // authSnapshot.data == false
                          // ?
                          AuthScreen()
                  //: ProductsScreen(),
                  ),
          routes: {
            ProductsScreen.routeName: (ctx) => ProductsScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
