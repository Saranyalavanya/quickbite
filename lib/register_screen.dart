import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
  controller: _nameController,
  decoration: InputDecoration(
    labelText: 'Full Name',
    prefixIcon: const Icon(Icons.person_outline),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    return null;
  },
),
const SizedBox(height: 16),
TextFormField(
  controller: _emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: const Icon(Icons.email_outlined),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailPattern = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\.\-]+$');
    if (!emailPattern.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  },
),
const SizedBox(height: 16),
TextFormField(
  controller: _phoneController,
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(
    labelText: 'Phone Number',
    prefixIcon: const Icon(Icons.phone_outlined),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.trim().length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  },
),
const SizedBox(height: 16),
TextFormField(
  controller: _passwordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: const Icon(Icons.lock_outline),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  },
),
const SizedBox(height: 16),
TextFormField(
  controller: _confirmPasswordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Confirm Password',
    prefixIcon: const Icon(Icons.lock_outline),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  },
),
const SizedBox(height: 24),
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepOrange,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created! Please log in.')),
      );
    }
  },
  child: const Text(
    'Register',
    style: TextStyle(fontSize: 16, color: Colors.white),
  ),
),
                // name field will go here
                // email field will go here
                // phone field will go here
                // password field will go here
                // confirm password field will go here
                // register button will go here
              ],
            ),
          ),
        ),
      ),
    );
  }
}