import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:izam_task/src/cart/entities/cart.dart';

class CartBottomBar extends StatelessWidget {
  final BottomSheetBarController controller;
  final Cart cart;
  const CartBottomBar({super.key, required this.controller, required this.cart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemCount = cart.items.fold<int>(0, (sum, item) => sum + item.quantity);

    return AnimatedContainer(
      duration: Durations.short4,
      margin: const EdgeInsets.all(16),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => controller.expand(),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.8)]),
            ),
            child: Row(
              children: [
                Badge(label: Text(itemCount.toString()), child: Icon(Icons.shopping_cart, color: theme.colorScheme.onPrimary, size: 36)),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        itemCount == 0 ? 'Your cart is empty' : '$itemCount item${itemCount == 1 ? '' : 's'} in cart',
                        style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(0.9), fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      if (itemCount > 0)
                        Text(
                          'Subtotal: \$${cart.totals.subtotal.toStringAsFixed(2)}',
                          style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(0.7), fontSize: 14),
                        ),
                    ],
                  ),
                ),

                // Total and Action
                Text(
                  '\$${cart.totals.total.toStringAsFixed(2)}',
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
