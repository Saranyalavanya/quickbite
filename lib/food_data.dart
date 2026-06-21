class Food {
  final String name;
  final String category;
  final double price;
  final double rating;
  final String description;
  final List<String> ingredients;
  final String imageUrl;

  Food({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
  });
}

List<Food> foodList = [
  Food(
    name: 'Margherita Pizza',
    category: 'Pizza',
    price: 199,
    rating: 4.5,
    description: 'Classic pizza topped with fresh mozzarella, tomato sauce and basil.',
    ingredients: ['Mozzarella cheese', 'Tomato sauce', 'Fresh basil', 'Pizza dough', 'Olive oil'],
    imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
  ),
  Food(
    name: 'Cheese Burger',
    category: 'Burger',
    price: 129,
    rating: 4.3,
    description: 'Juicy grilled patty with cheese, lettuce and our special sauce.',
    ingredients: ['Beef patty', 'Cheddar cheese', 'Lettuce', 'Tomato', 'Burger bun', 'Special sauce'],
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
  ),
  Food(
    name: 'Chicken Biryani',
    category: 'Biryani',
    price: 249,
    rating: 4.7,
    description: 'Fragrant basmati rice cooked with spiced chicken and herbs.',
    ingredients: ['Basmati rice', 'Chicken', 'Biryani masala', 'Onions', 'Yogurt', 'Mint leaves'],
    imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400',
  ),
  Food(
    name: 'Cold Coffee',
    category: 'Drinks',
    price: 89,
    rating: 4.2,
    description: 'Chilled coffee blended with milk and ice cream.',
    ingredients: ['Coffee', 'Milk', 'Ice cream', 'Sugar', 'Ice cubes'],
    imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=400',
  ),
  Food(
    name: 'Chocolate Brownie',
    category: 'Desserts',
    price: 99,
    rating: 4.6,
    description: 'Rich, fudgy chocolate brownie served warm.',
    ingredients: ['Dark chocolate', 'Butter', 'Eggs', 'Flour', 'Sugar', 'Walnuts'],
    imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400',
  ),
  Food(
    name: 'Veg Pizza',
    category: 'Pizza',
    price: 179,
    rating: 4.1,
    description: 'Loaded with fresh vegetables and mozzarella cheese.',
    ingredients: ['Mozzarella cheese', 'Bell peppers', 'Onions', 'Sweet corn', 'Olives', 'Pizza dough'],
    imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400',
  ),
];

List<String> categoryList = ['Pizza', 'Burger', 'Biryani', 'Drinks', 'Desserts'];