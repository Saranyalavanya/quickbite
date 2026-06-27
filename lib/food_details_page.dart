import 'package:flutter/material.dart';
import 'food_data.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';


class FoodDetailsPage extends StatefulWidget {
  final Food food;

  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: Text(widget.food.name),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.food.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 180,
                    color: const Color(0xFFFFE0B2),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: const Color(0xFFFFE0B2),
                    child: const Center(
                      child: Icon(Icons.fastfood,
                          size: 70, color: Colors.deepOrange),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.food.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text(' ${widget.food.rating}'),
                const SizedBox(width: 16),
                Text(
                  '₹${widget.food.price.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.food.description,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingredients',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.food.ingredients.map((item) {
                return Chip(
                  label: Text(item),
                  backgroundColor: const Color(0xFFFFE0B2),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text('Quantity:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_quantity', style: const TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 0),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                  .addToCart(widget.food, quantity: _quantity);
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('${widget.food.name} added to cart')),
  );
},

              child: const Text('Add to Cart',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}