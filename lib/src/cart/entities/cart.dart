import 'package:izam_task/src/cart/entities/cart_item.dart';
import 'package:izam_task/src/cart/entities/cart_totals.dart';

class Cart {
  final List<CartItem> items;
  final CartTotals totals;
  final double cartDiscountPercentage; // Added cart-wide discount percentage

  Cart({
    required this.items,
    required this.totals,
    this.cartDiscountPercentage = 0.0, // Default to 0% cart discount
  });

  Cart copyWith({List<CartItem>? items, CartTotals? totals, double? cartDiscountPercentage}) {
    return Cart(
      items: items ?? this.items,
      totals: totals ?? this.totals,
      cartDiscountPercentage: cartDiscountPercentage ?? this.cartDiscountPercentage,
    );
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List<dynamic>).map((item) => CartItem.fromJson(item as Map<String, dynamic>)).toList(),
      totals: CartTotals.fromJson(json['totals'] as Map<String, dynamic>),
      cartDiscountPercentage: (json['cartDiscountPercentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((item) => item.toJson()).toList(), 'totals': totals.toJson(), 'cartDiscountPercentage': cartDiscountPercentage};
  }

  @override
  String toString() {
    return 'Cart(items: $items, totals: $totals, cartDiscountPercentage: ${(cartDiscountPercentage * 100).toStringAsFixed(1)}%)';
  }
}
