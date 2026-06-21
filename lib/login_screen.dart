import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: Form(
    key: _formKey,
    child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  // logo + title will go here
               const Icon(
                Icons.fastfood,
                size: 80,
                color: Colors.deepOrange,
              ),
const SizedBox(height: 12),
const Text(
  'QuickBite',
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.deepOrange,
  ),
),
const SizedBox(height: 32),
                  // email field will go here
TextFormField(
  controller: _emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: const Icon(Icons.email_outlined),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
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
                  // password field will go here
TextFormField(
  controller: _passwordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: const Icon(Icons.lock_outline),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  },
),
const SizedBox(height: 8),
Align(
  alignment: Alignment.centerRight,
  child: TextButton(
  onPressed: () {
      // forgot password logic placeholder - not connected for now
    },
    child: const Text('Forgot Password?'),
  ),
),
const SizedBox(height: 16),
                  // login button will go here
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepOrange,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      // all fields are valid - login logic will go here later
      Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
    );
    }
  },
  child: const Text(
    'Login',
    style: TextStyle(fontSize: 16, color: Colors.white),
  ),
),
const SizedBox(height: 16),
Center(
  child: TextButton(
    onPressed: () {
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
     // navigation to Register screen will go here later
    },
    child: const Text('New user? Register here'),
  ),
),
                ],
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}