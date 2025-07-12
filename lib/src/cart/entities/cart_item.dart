import 'package:izam_task/src/catalog/entities/item.dart';

class CartItem {
  final Item item;
  final int quantity;
  final double discountPercentage; // Discount percentage per line (0.0 to 1.0)

  const CartItem({
    required this.item,
    required this.quantity,
    this.discountPercentage = 0.0, // Default to 0% discount
  });

  CartItem copyWith({Item? item, int? quantity, double? discountPercentage}) =>
      CartItem(item: item ?? this.item, quantity: quantity ?? this.quantity, discountPercentage: discountPercentage ?? this.discountPercentage);

  /// Business rule: lineNet = price × qty × (1 – discount%)
  /// This is the net amount after applying the line-level discount
  double get lineNet {
    final baseAmount = item.price * quantity;
    final discountAmount = baseAmount * discountPercentage;
    return baseAmount - discountAmount;
  }

  /// Original price before any discounts
  double get originalTotal => item.price * quantity;

  /// Amount saved due to line discount
  double get discountAmount => originalTotal - lineNet;

  /// Keep totalPrice for backwards compatibility
  double get totalPrice => lineNet;

  /// Helper to get discount percentage as a readable string
  String get discountPercentageString => '${(discountPercentage * 100).toStringAsFixed(1)}%';

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'item': item.toJson(), 'quantity': quantity, 'discountPercentage': discountPercentage};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          item == other.item &&
          quantity == other.quantity &&
          discountPercentage == other.discountPercentage;

  @override
  int get hashCode => item.hashCode ^ quantity.hashCode ^ discountPercentage.hashCode;

  @override
  String toString() {
    final discountInfo = discountPercentage > 0 ? ' (${discountPercentageString} off)' : '';
    return 'CartItem(${item.name} x$quantity$discountInfo = \$${lineNet.toStringAsFixed(2)})';
  }
}
