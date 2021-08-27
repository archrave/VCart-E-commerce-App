import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_route.dart';
import '../providers/auth.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/products_screen.dart';

class MainDrawer extends StatelessWidget {
  // void _showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text('Confirm Logout'),
  //       content: Text('Are you sure you want to logout?'),
  //       actions: [
  //         FlatButton(
  //             child: Text('Cancel'),
  //             textColor: Theme.of(ctx).accentColor,
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             }),
  //         FlatButton(
  //           child: Text('Logout'),
  //           textColor: Theme.of(ctx).accentColor,
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             Provider.of<Auth>(ctx, listen: false).logout();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.pages),
            title: Text(
              'My Orders',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Manage your products', style: TextStyle(fontSize: 15)),
            onTap: () {
              //Follwing is the connection to a custom route animation
              // //   // Navigator.of(context).pushReplacement(
              // //   //   CustomRoute(
              // //   //     builder: (ctx) => UserProductsScreen(),
              // //   //   ),
              // //   // );
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout', style: TextStyle(fontSize: 15)),
            onTap: () {
              Navigator.of(context).pop();
              // Naviagting to the home screen, as we want to rebuild the Consumer<Auth> inside the main.dart so that the logic for selecting the right screen on bootup, runs again.
              // Basically this makes sures that we don't see any unexpected behaviours when logging out
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
