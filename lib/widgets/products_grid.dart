import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* So, 'Provider.' basically allows us to use the provided CLASSES
    (in out case we're only using 'Providers class' yet) */

    /*AND to use that provided class we also need to set up a provider
    widget (as we did in main.dart (ChangeNotifierProvider) ; in some part widget of this curret widget that we're using*/
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (context, index) {
        /* This .value syntax doesn't take the context as the create: syntax does
           Advantage of using .value is that the widget under it will surely rebuild;
           unlike in the previous case where only the data gets updated and the widget gets 
           recycled, which might result in errors. So .value is the correct apporach whenever
           we are using ListView/Gridview or any builder */

        return ChangeNotifierProvider.value(
          value: products[index],
          // ChangeNotifierProvider(
          //   create: (ctx) => products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
