import 'package:equatable/equatable.dart';

class CartTotals extends Equatable  {
  final double subtotal; // Σ lineNet
  final double vat; // subtotal × 0.15
  final double grandTotal; // subtotal + vat
  final double discount; // Total discount amount (for display purposes)

  const CartTotals({this.subtotal = 0.0, this.vat = 0.0, this.grandTotal = 0.0, this.discount = 0.0});

  // Keep tax for backwards compatibility - it's the same as VAT
  double get tax => vat;

  // Keep total for backwards compatibility - it's the same as grandTotal
  double get total => grandTotal;

  factory CartTotals.fromJson(Map<String, dynamic> json) {
    return CartTotals(
      subtotal: (json['subtotal'] as num).toDouble(),
      vat: (json['vat'] as num).toDouble(),
      grandTotal: (json['grandTotal'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'subtotal': subtotal, 'vat': vat, 'grandTotal': grandTotal, 'discount': discount};
  }

  @override
  String toString() {
    return 'CartTotals(subtotal: \$${subtotal.toStringAsFixed(2)}, vat: \$${vat.toStringAsFixed(2)}, grandTotal: \$${grandTotal.toStringAsFixed(2)}, discount: \$${discount.toStringAsFixed(2)})';
  }
  
  @override
  List<Object?> get props => [subtotal, vat, grandTotal, discount];
}
