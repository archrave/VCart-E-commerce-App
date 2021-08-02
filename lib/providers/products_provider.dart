// with keyword adds a 'mixin' which is basically 'inheritance-lite'
import 'package:flutter/cupertino.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> _productList = [];

// Made this copy of the above private list because when we change data in this list via some other widget , we wouldn't be able to run the notifylisteners() function to let all the other  widgets know that the data has been changed
  List<Product> get items {
    return [..._items];
  }

// Defined a logic to get all the data of a particular product just using it's id (provided we already have the id)
  Product findById(String getId) {
    return items.firstWhere((element) => getId == element.id);
  }

  void addProduct() {
    // Establishes a communication channel with the listeners of this particular provider
    notifyListeners();
  }
}
