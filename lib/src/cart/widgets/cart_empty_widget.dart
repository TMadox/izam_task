import 'package:flutter/material.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: CartConstants.largeIconSize, color: CartConstants.primaryColor),
          SizedBox(height: CartConstants.spacing),
          Text('Your cart is empty', style: CartConstants.titleStyle),
          SizedBox(height: CartConstants.smallSpacing),
          Text('Add some items from the catalog', style: CartConstants.subtitleStyle),
        ],
      ),
    );
  }
}
