import 'dart:math';
import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:intl/intl.dart';

class OrderUI extends StatefulWidget {
  final OrderItem order;

  OrderUI(this.order);

  @override
  _OrderUIState createState() => _OrderUIState();
}

class _OrderUIState extends State<OrderUI> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 150,
      ),
      height:
          //Increased the height 100 more than the inner container
          _expanded ? min(widget.order.products.length * 20.0 + 140, 200) : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('₹${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(!_expanded ? Icons.expand_more : Icons.expand_less),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 40, 180)
                  : 0,
              child: ListView(
                children: widget.order.products.map((prod) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prod.title,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '${prod.quantity} x ${prod.price}',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
