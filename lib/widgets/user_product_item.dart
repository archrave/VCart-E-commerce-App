import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imgUrl;
  final String id;
  UserProductItem({
    @required this.title,
    @required this.price,
    @required this.imgUrl,
    @required this.id,
  });
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      subtitle: Text('₹$price'),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting Failed '),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
