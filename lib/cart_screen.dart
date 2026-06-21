import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.food.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: const Color(0xFFFFE0B2),
                                  child: const Icon(Icons.fastfood,
                                      color: Colors.deepOrange),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.food.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                    '₹${item.food.price.toStringAsFixed(0)}'),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline,
                                size: 20),
                            onPressed: () {
                              context.read<CartProvider>().decreaseQuantity(item);
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline,
                                size: 20),
                            onPressed: () {
                              context.read<CartProvider>().increaseQuantity(item);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red, size: 20),
                            onPressed: () {
                              context.read<CartProvider>().removeFromCart(item);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          '₹${cart.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      onPressed: () {
                        // checkout navigation will go here later
                      },
                      child: const Text('Proceed to Checkout',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}