import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    print('> User screen build method start!');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (_ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(10),
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return Column(
                              children: [
                                UserProductItem(
                                  title: productsData.items[i].title,
                                  price: productsData.items[i].price,
                                  imgUrl: productsData.items[i].imageUrl,
                                  id: productsData.items[i].id,
                                ),
                                Divider(),
                              ],
                            );
                          },
                          itemCount: productsData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
