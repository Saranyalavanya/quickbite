import 'package:flutter/material.dart';
import 'food_data.dart';
import 'food_details_page.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';
import 'wishlist_provider.dart';
import 'wishlist_screen.dart';

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
          IconButton(
  icon: const Icon(Icons.favorite_border),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WishlistScreen()),
    );
  },
),
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
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()),
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
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
              height: 90,
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
                  mainAxisExtent: 270,
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
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  height: 130,
                                  color: const Color(0xFFFFE0B2),
                                  child: const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 130,
                                  color: const Color(0xFFFFE0B2),
                                  child: const Center(
                                    child: Icon(Icons.fastfood,
                                        size: 40, color: Colors.deepOrange),
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
                                const SizedBox(height: 2),
                                Text(
                                  food.restaurantName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.black54),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 14, color: Colors.amber),
                                    Text(' ${food.rating}',
                                        style: const TextStyle(fontSize: 12)),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.timer_outlined,
                                        size: 12, color: Colors.black54),
                                    Text(' ${food.deliveryTime}',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54)),
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
                                    Row(
                                      children: [
                                        Consumer<WishlistProvider>(
                                          builder: (context, wishlist, child) {
                                            final isFav =
                                                wishlist.isInWishlist(food);
                                            return InkWell(
                                              onTap: () {
                                                wishlist.toggleWishlist(food);
                                              },
                                              child: Icon(
                                                isFav
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isFav
                                                    ? Colors.red
                                                    : Colors.black54,
                                                size: 20,
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .addToCart(food);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      '${food.name} added to cart')),
                                            );
                                          },
                                          child: const Icon(Icons.add_circle,
                                              color: Colors.deepOrange),
                                        ),
                                      ],
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

    IconData icon;
    switch (category) {
      case 'Pizza':
        icon = Icons.local_pizza;
        break;
      case 'Burger':
        icon = Icons.lunch_dining;
        break;
      case 'Biryani':
        icon = Icons.rice_bowl;
        break;
      case 'Drinks':
        icon = Icons.local_drink;
        break;
      case 'Desserts':
        icon = Icons.cake;
        break;
      case 'Fast Food':
        icon = Icons.fastfood;
        break;
      case 'South Indian':
        icon = Icons.breakfast_dining;
        break;
      case 'Chinese':
        icon = Icons.ramen_dining;
        break;
      default:
        icon = Icons.restaurant_menu;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepOrange : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.deepOrange,
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.deepOrange : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}