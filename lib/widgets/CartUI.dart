import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartUI extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartUI({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: FittedBox(child: Text('₹$price')),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total: ₹${price * quantity}'),
              trailing: Text('x $quantity'),
            ),
          )),
    );
  }
}
