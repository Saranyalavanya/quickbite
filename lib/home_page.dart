import 'package:flutter/material.dart';
import 'food_data.dart';
import 'food_details_page.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    // filtered list based on category + search
    List<Food> filteredFoods = foodList.where((food) {
      bool matchesCategory =
          _selectedCategory == 'All' || food.category == _selectedCategory;
      bool matchesSearch =
          food.name.toLowerCase().contains(_searchText.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('QuickBite'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          Consumer<CartProvider>(
    builder: (context, cart, child) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          if (cart.totalItemCount > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${cart.totalItemCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      );
    },
  ),
  IconButton(
    icon: const Icon(Icons.person_outline),
    onPressed: () {
      // profile page navigation will go here later
    },
  ),
],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _categoryChip('All'),
                  ...categoryList.map((cat) => _categoryChip(cat)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Popular Food',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                itemCount: filteredFoods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 210,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final food = filteredFoods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailsPage(food: food),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
  child: Image.network(
    food.imageUrl,
    height: 90,
    width: double.infinity,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;
      return Container(
        height: 90,
        color: const Color(0xFFFFE0B2),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        height: 90,
        color: const Color(0xFFFFE0B2),
        child: const Center(
          child: Icon(Icons.fastfood, size: 40, color: Colors.deepOrange),
        ),
      );
    },
  ),
),

                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 14, color: Colors.amber),
                                    Text(' ${food.rating}',
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '₹${food.price.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    InkWell(
                                    onTap: () {
                                      Provider.of<CartProvider>(context, listen: false).addToCart(food);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${food.name} added to cart')),
                                    );
                                  },
                                child: const Icon(Icons.add_circle, color: Colors.deepOrange),
                                  ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),


      ),
    );
  }

  Widget _categoryChip(String category) {
    bool isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        selectedColor: Colors.deepOrange,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
      ),
    );
  }
}