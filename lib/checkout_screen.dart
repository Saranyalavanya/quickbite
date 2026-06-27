import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'order_success_screen.dart';
import 'package:flutter/services.dart';
import 'user_provider.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _upiController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  String _paymentMethod = 'Cash on Delivery';

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _upiController.dispose();
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter your full delivery address',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Mobile number is required';
  }
  
  if (value.trim().length != 10) {
    return 'Mobile number must contain exactly 10 digits';
  }
  return null;
},
              ),
              const SizedBox(height: 16),
              const Text('Payment Method',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
const SizedBox(height: 8),
Column(
  children: ['Cash on Delivery', 'UPI', 'Card']
      .map((method) => RadioListTile<String>(
            value: method,
            groupValue: _paymentMethod,
            activeColor: Colors.deepOrange,
            title: Text(method),
            tileColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _paymentMethod = value!;
              });
            },
          ))
      .toList(),
),
const SizedBox(height: 16),

if (_paymentMethod == 'UPI') ...[
  TextFormField(
    controller: _upiController,
    decoration: InputDecoration(
      labelText: 'UPI ID',
      hintText: 'example@upi',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    validator: (value) {
      if (_paymentMethod != 'UPI') return null;
      if (value == null || value.trim().isEmpty) {
        return 'UPI ID is required';
      }
      final upiPattern = RegExp(r'^[\w.\-]+@[\w]+$');
      if (!upiPattern.hasMatch(value.trim())) {
        return 'Enter a valid UPI ID (e.g. name@bank)';
      }
      return null;
    },
  ),
  const SizedBox(height: 16),
],
if (_paymentMethod == 'Card') ...[
  TextFormField(
    controller: _cardNameController,
    decoration: InputDecoration(
      labelText: 'Card Holder Name',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    validator: (value) {
      if (_paymentMethod != 'Card') return null;
      if (value == null || value.trim().isEmpty) {
        return 'Card holder name is required';
      }
      return null;
    },
  ),
  const SizedBox(height: 12),
  TextFormField(
    controller: _cardNumberController,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: InputDecoration(
      labelText: 'Card Number',
      hintText: '16 digit card number',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    validator: (value) {
      if (_paymentMethod != 'Card') return null;
      if (value == null || value.trim().isEmpty) {
        return 'Card number is required';
      }
      if (value.trim().length != 16) {
        return 'Card number must be 16 digits';
      }
      return null;
    },
  ),
  const SizedBox(height: 12),
  Row(
    children: [
      Expanded(
        child: TextFormField(
          controller: _expiryController,
          decoration: InputDecoration(
            labelText: 'Expiry (MM/YY)',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (_paymentMethod != 'Card') return null;
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
            final expiryPattern = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
            if (!expiryPattern.hasMatch(value.trim())) {
              return 'Use MM/YY format';
            }
            return null;
          },
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TextFormField(
          controller: _cvvController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'CVV',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (_paymentMethod != 'Card') return null;
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
            if (value.trim().length != 3) {
              return 'CVV must be 3 digits';
            }
            return null;
          },
        ),
      ),
    ],
  ),
  const SizedBox(height: 16),
],

              const Text('Order Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: cart.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item.food.name} x${item.quantity}'),
                          Text(
                              '₹${(item.food.price * item.quantity).toStringAsFixed(0)}'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                     final userEmail = context.read<UserProvider>().email;
                      context.read<CartProvider>().placeOrder(_paymentMethod, userEmail);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderSuccessScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Place Order',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}