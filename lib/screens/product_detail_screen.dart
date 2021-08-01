import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  //ProductDetailScreen(this.prodTitle, this.prodImg);
  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          title: Text('helu'),
        ),
        body: Container(
            //child: Image.network(prodImg),
            ));
  }
}
