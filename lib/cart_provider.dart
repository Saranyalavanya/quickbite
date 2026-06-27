import 'package:flutter/material.dart';
import 'food_data.dart';

class CartItem {
  final Food food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});
}

class PlacedOrder {
  final String orderId;
  final String userEmail;
  final List<CartItem> items;
  final double total;
  final String paymentMethod;
  final DateTime orderDate;

  PlacedOrder({
    required this.orderId,
    required this.userEmail,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.orderDate,
  });

  String get status {
    final minutesPassed = DateTime.now().difference(orderDate).inMinutes;
    if (minutesPassed < 1) return 'Order Placed';
    if (minutesPassed < 2) return 'Preparing';
    if (minutesPassed < 3) return 'Out for Delivery';
    return 'Delivered';
  }
}


class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<PlacedOrder> _orderHistory = [];


  List<CartItem> get items => _items;
  List<PlacedOrder> get orderHistory => _orderHistory;

  void placeOrder(String paymentMethod, String userEmail) {
  final newOrderId = 'QB${DateTime.now().millisecondsSinceEpoch}';
  _orderHistory.add(
    PlacedOrder(
      orderId: newOrderId,
      userEmail: userEmail,
      items: List.from(_items),
      total: totalPrice,
      paymentMethod: paymentMethod,
      orderDate: DateTime.now(),
    ),
  );
  notifyListeners();
}

List<PlacedOrder> ordersForUser(String email) {
  return _orderHistory.where((order) => order.userEmail == email).toList();
}

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
  void clearCart() {
  _items.clear();
  notifyListeners();
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