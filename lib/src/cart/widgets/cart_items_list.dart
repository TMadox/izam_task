import 'package:flutter/material.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';
import 'package:izam_task/src/cart/entities/cart.dart';
import 'package:izam_task/src/cart/widgets/cart_item_card.dart';

class CartItemsList extends StatelessWidget {
  final Cart cart;

  const CartItemsList({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(CartConstants.padding),
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = cart.items[index];
          return CartItemCard(cartItem: cartItem);
        },
      ),
    );
  }
}
