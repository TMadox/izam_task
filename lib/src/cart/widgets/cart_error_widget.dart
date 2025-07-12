import 'package:flutter/material.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';

class CartErrorWidget extends StatelessWidget {
  final String message;

  const CartErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: CartConstants.iconSize, color: CartConstants.errorColor),
          const SizedBox(height: CartConstants.spacing),
          Text(message, style: CartConstants.errorTextStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
