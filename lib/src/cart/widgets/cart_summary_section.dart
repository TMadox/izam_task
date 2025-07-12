import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/app/extensions/num_extension.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';
import 'package:izam_task/src/cart/entities/cart.dart';

class CartSummarySection extends StatelessWidget {
  final Cart cart;

  const CartSummarySection({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CartConstants.padding),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(CartConstants.largeBorderRadius)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:', style: CartConstants.vatTextStyle),
              Text(cart.totals.subtotal.money, style: CartConstants.vatTextStyle),
            ],
          ),
          if (cart.totals.discount > 0) ...[
            const SizedBox(height: CartConstants.smallSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Discount:', style: CartConstants.discountTextStyle),
                Text('-${cart.totals.discount.money}', style: CartConstants.discountTextStyle),
              ],
            ),
          ],
          const SizedBox(height: CartConstants.smallSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('VAT (15%):', style: CartConstants.vatTextStyle), Text(cart.totals.vat.money, style: CartConstants.vatTextStyle)],
          ),
          const Divider(height: CartConstants.dividerHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Total:', style: CartConstants.totalStyle), Text(cart.totals.grandTotal.money, style: CartConstants.totalStyle)],
          ),
          const SizedBox(height: CartConstants.spacing),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.read<CartBloc>().add(Checkout()),
              style: ElevatedButton.styleFrom(
                backgroundColor: CartConstants.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
