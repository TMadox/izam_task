import 'package:flutter/material.dart';
import 'package:izam_task/src/cart/entities/cart.dart';
import 'package:izam_task/src/cart/entities/cart_item.dart';

class ShoppingCartWidget extends StatelessWidget {
  final Cart cart;
  final VoidCallback? onClearCart;
  final Function(String itemId, int newQuantity)? onUpdateQuantity;
  final Function(String itemId)? onRemoveItem;
  final VoidCallback? onCheckout;
  final bool showCheckoutButton;
  final bool showClearButton;
  final String? emptyCartMessage;
  final String? checkoutButtonText;

  const ShoppingCartWidget({
    super.key,
    required this.cart,
    this.onClearCart,
    this.onUpdateQuantity,
    this.onRemoveItem,
    this.onCheckout,
    this.showCheckoutButton = true,
    this.showClearButton = true,
    this.emptyCartMessage,
    this.checkoutButtonText,
  });

  @override
  Widget build(BuildContext context) {
    if (cart.items.isEmpty) {
      return _buildEmptyCart();
    }

    return Column(
      children: [
        // Cart Items List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final cartItem = cart.items[index];
              return _buildCartItem(context, cartItem);
            },
          ),
        ),
        // Cart Summary
        _buildCartSummary(context),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 80, color: Color(0xFF6366F1)),
          const SizedBox(height: 16),
          const Text('Your cart is empty', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(emptyCartMessage ?? 'Add some items to get started', style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image/Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.inventory_2, color: Color(0xFF6366F1), size: 32),
            ),
            const SizedBox(width: 16),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('\$${cartItem.item.price.toStringAsFixed(2)} each', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Quantity Controls
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildQuantityButton(icon: Icons.remove, onPressed: () => _handleQuantityDecrease(cartItem)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text('${cartItem.quantity}', style: const TextStyle(fontWeight: FontWeight.w600)),
                            ),
                            _buildQuantityButton(icon: Icons.add, onPressed: () => _handleQuantityIncrease(cartItem)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Item Total
                      Text(
                        '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6366F1)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Remove Button
            IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => onRemoveItem?.call(cartItem.item.id)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 20, color: onPressed != null ? const Color(0xFF6366F1) : Colors.grey),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Column(
        children: [
          // Order Summary
          _buildSummaryRow('Subtotal', cart.totals.subtotal),
          if (cart.totals.tax > 0) ...[const SizedBox(height: 8), _buildSummaryRow('Tax', cart.totals.tax)],
          if (cart.totals.discount > 0) ...[const SizedBox(height: 8), _buildSummaryRow('Discount', -cart.totals.discount, isDiscount: true)],
          const Divider(height: 24),
          _buildSummaryRow('Total', cart.totals.total > 0 ? cart.totals.total : cart.totals.subtotal, isTotal: true),
          const SizedBox(height: 20),
          // Action Buttons
          Row(
            children: [
              if (showClearButton && cart.items.isNotEmpty) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showClearCartDialog(context),
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Clear Cart'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      side: BorderSide(color: Colors.grey[300]!),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              if (showCheckoutButton) ...[
                Expanded(
                  flex: showClearButton ? 2 : 1,
                  child: ElevatedButton.icon(
                    onPressed: onCheckout,
                    icon: const Icon(Icons.shopping_bag),
                    label: Text(checkoutButtonText ?? 'Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          '\$${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color:
                isTotal
                    ? const Color(0xFF6366F1)
                    : isDiscount
                    ? Colors.green
                    : Colors.black,
          ),
        ),
      ],
    );
  }

  void _handleQuantityIncrease(CartItem cartItem) {
    onUpdateQuantity?.call(cartItem.item.id, cartItem.quantity + 1);
  }

  void _handleQuantityDecrease(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      onUpdateQuantity?.call(cartItem.item.id, cartItem.quantity - 1);
    } else {
      onRemoveItem?.call(cartItem.item.id);
    }
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Clear Cart'),
            content: const Text('Are you sure you want to remove all items from your cart?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  onClearCart?.call();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white),
                child: const Text('Clear Cart'),
              ),
            ],
          ),
    );
  }
}
