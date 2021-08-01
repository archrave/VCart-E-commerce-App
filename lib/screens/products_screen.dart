import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Shop'),
      ),

      //Moved the Gridview.builder() to a separate widget so that the appBar above doesn't rebuild unnecessarily.

      body: ProductsGrid(),
    );
  }
}
