import 'package:flutter/material.dart';

class CartLoadingWidget extends StatelessWidget {
  const CartLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
