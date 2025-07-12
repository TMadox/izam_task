import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';
import 'package:izam_task/src/cart/entities/cart.dart';

class CartDiscountSection extends StatefulWidget {
  final Cart cart;

  const CartDiscountSection({super.key, required this.cart});

  @override
  State<CartDiscountSection> createState() => _CartDiscountSectionState();
}

class _CartDiscountSectionState extends State<CartDiscountSection> {
  final TextEditingController _discountController = TextEditingController();

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CartConstants.padding),
      decoration: BoxDecoration(color: Colors.grey[50], border: Border(top: BorderSide(color: Colors.grey[300]!))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Discount', style: CartConstants.sectionTitleStyle),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter discount % (0-100)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(CartConstants.borderRadius)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    suffixText: '%',
                  ),
                ),
              ),
              const SizedBox(width: CartConstants.smallSpacing),
              ElevatedButton(
                onPressed: () {
                  final discountText = _discountController.text.trim();
                  if (discountText.isNotEmpty) {
                    final discount = double.tryParse(discountText);
                    if (discount != null && discount >= 0 && discount <= 100) {
                      context.read<CartBloc>().add(ApplyCartDiscount(discount / 100));
                      _discountController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid discount percentage (0-100)')));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: CartConstants.primaryColor, foregroundColor: Colors.white),
                child: const Text('Apply'),
              ),
            ],
          ),
          if (widget.cart.cartDiscountPercentage > 0) ...[
            const SizedBox(height: CartConstants.smallSpacing),
            Row(
              children: [
                Icon(Icons.discount, color: CartConstants.discountColor, size: CartConstants.smallIconSize),
                const SizedBox(width: 4),
                Text('Cart discount: ${(widget.cart.cartDiscountPercentage * 100).toStringAsFixed(1)}%', style: CartConstants.discountTextStyle),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.read<CartBloc>().add(RemoveCartDiscount());
                    _discountController.clear();
                  },
                  child: const Text('Remove', style: CartConstants.removeTextStyle),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
