import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imgUrl;
  UserProductItem({
    @required this.title,
    @required this.price,
    @required this.imgUrl,
  });
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
