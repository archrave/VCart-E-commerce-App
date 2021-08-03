import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  //ProductDetailScreen(this.prodTitle, this.prodImg);
  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context).settings.arguments as String;

    // Used the logic from the Providers class to get an entire Product item just from its id

    /* This is the product detail screen, and whenever we add or remove Products from our list, 
       we don't really NEED this screen widget to rebuild, so we've set listen: false so that 
       it doesn't rebuild whenever the Provided object changes (listen: true by default) */

    final thisProduct =
        Provider.of<Products>(context, listen: false).findById(prodId);
    return Scaffold(
      appBar: AppBar(
        title: Text(thisProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 300,
              width: double.infinity,
              child: Image.network(
                thisProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '₹${thisProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${thisProduct.description}',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
