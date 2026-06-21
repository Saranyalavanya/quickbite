import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // wait 3 seconds, then move to next screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
      // we will add navigation to Login Screen here once it's ready
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fastfood,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'QuickBite',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}