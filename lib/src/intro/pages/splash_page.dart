import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izam_task/app/utils/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go(AppRouter.catalog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.store, size: 100, color: Colors.white),
              SizedBox(height: 24),
              Text('POS System', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 16),
              Text('Point of Sale Solution', style: TextStyle(fontSize: 16, color: Colors.white70)),
              SizedBox(height: 48),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
