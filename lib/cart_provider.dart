import 'package:flutter/material.dart';
import 'food_data.dart';

class CartItem {
  final Food food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Food food, {int quantity = 1}) {
    // check if this food is already in the cart
    int existingIndex = _items.indexWhere((item) => item.food.name == food.name);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(food: food, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.food.price * item.quantity;
    }
    return total;
  }

  int get totalItemCount {
    int count = 0;
    for (var item in _items) {
      count += item.quantity;
    }
    return count;
  }
}