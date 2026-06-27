import 'package:flutter/material.dart';
import 'food_data.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Food> _wishlist = [];

  List<Food> get wishlist => _wishlist;

  bool isInWishlist(Food food) {
    return _wishlist.any((item) => item.name == food.name);
  }

  void toggleWishlist(Food food) {
    if (isInWishlist(food)) {
      _wishlist.removeWhere((item) => item.name == food.name);
    } else {
      _wishlist.add(food);
    }
    notifyListeners();
  }
}