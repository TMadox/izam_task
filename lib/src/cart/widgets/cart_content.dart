import 'package:flutter/material.dart';
import 'package:izam_task/src/cart/entities/cart.dart';
import 'package:izam_task/src/cart/widgets/cart_discount_section.dart';
import 'package:izam_task/src/cart/widgets/cart_items_list.dart';
import 'package:izam_task/src/cart/widgets/cart_summary_section.dart';

class CartContent extends StatelessWidget {
  final Cart cart;

  const CartContent({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Column(children: [CartItemsList(cart: cart), CartDiscountSection(cart: cart), CartSummarySection(cart: cart)]);
  }
}
