import 'package:flutter/foundation.dart';

// Added this ChangeNotifier so that whenever a Favorite (at this stage only for the favorite value) value changes, it notifies all listeners
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    //It's safe to say that this notifyListeners() function is kind of like setState()
    notifyListeners();
  }
}
