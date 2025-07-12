import 'package:izam_task/src/cart/entities/cart.dart';

/// Receipt DTO with header, lines, and totals structure
class Receipt {
  final ReceiptHeader header;
  final List<ReceiptLine> lines;
  final ReceiptTotals totals;

  const Receipt({required this.header, required this.lines, required this.totals});

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('=' * 40);
    buffer.writeln('RECEIPT #${header.receiptNumber}');
    buffer.writeln('=' * 40);
    buffer.writeln('Date: ${header.formattedTimestamp}');
    buffer.writeln('-' * 40);

    for (final line in lines) {
      buffer.writeln('${line.itemName} x${line.quantity}');

      // Show original price and discount if applicable
      if (line.discountPercentage > 0) {
        buffer.writeln('  \$${line.unitPrice.toStringAsFixed(2)} each (${line.discountPercentageString} off)');
        buffer.writeln('  Line total: \$${line.lineTotal.toStringAsFixed(2)}');
      } else {
        buffer.writeln('  \$${line.unitPrice.toStringAsFixed(2)} each = \$${line.lineTotal.toStringAsFixed(2)}');
      }
    }

    buffer.writeln('-' * 40);
    buffer.writeln('Subtotal: \$${totals.subtotal.toStringAsFixed(2)}');
    buffer.writeln('VAT (15%): \$${totals.vat.toStringAsFixed(2)}');

    if (totals.discount > 0) {
      buffer.writeln('Total Discount: -\$${totals.discount.toStringAsFixed(2)}');
    }

    buffer.writeln('=' * 40);
    buffer.writeln('TOTAL: \$${totals.grandTotal.toStringAsFixed(2)}');
    buffer.writeln('=' * 40);

    return buffer.toString();
  }
}

/// Receipt header information
class ReceiptHeader {
  final String receiptNumber;
  final DateTime timestamp;

  const ReceiptHeader({required this.receiptNumber, required this.timestamp});

  String get formattedTimestamp {
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')} '
        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

/// Individual line item in the receipt
class ReceiptLine {
  final String itemId;
  final String itemName;
  final int quantity;
  final double unitPrice;
  final double lineTotal;
  final double discountPercentage;

  const ReceiptLine({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
    this.discountPercentage = 0.0,
  });

  /// Helper to get discount percentage as a readable string
  String get discountPercentageString => '${(discountPercentage * 100).toStringAsFixed(1)}% off';

  /// Amount saved on this line
  double get discountAmount => (unitPrice * quantity) - lineTotal;
}

/// Receipt totals summary
class ReceiptTotals {
  final double subtotal;
  final double vat;
  final double grandTotal;
  final double discount;

  const ReceiptTotals({required this.subtotal, required this.vat, required this.grandTotal, required this.discount});
}

/// Pure function to build a receipt from cart state
/// This is a requirement from the task specification
Receipt buildReceipt(Cart cart, DateTime timestamp) {
  // Validate cart state
  if (cart.items.isEmpty) {
    throw ArgumentError('Cannot build receipt for empty cart');
  }

  // Generate receipt number based on timestamp
  final receiptNumber = 'R${timestamp.millisecondsSinceEpoch.toString().substring(0, 8).toUpperCase()}';

  // Build header
  final header = ReceiptHeader(receiptNumber: receiptNumber, timestamp: timestamp);

  // Build lines from cart items
  final lines =
      cart.items
          .map(
            (cartItem) => ReceiptLine(
              itemId: cartItem.item.id,
              itemName: cartItem.item.name,
              quantity: cartItem.quantity,
              unitPrice: cartItem.item.price,
              lineTotal: cartItem.lineNet,
              discountPercentage: cartItem.discountPercentage,
            ),
          )
          .toList();

  // Build totals from cart totals
  final totals = ReceiptTotals(
    subtotal: cart.totals.subtotal,
    vat: cart.totals.vat,
    grandTotal: cart.totals.grandTotal,
    discount: cart.totals.discount,
  );

  return Receipt(header: header, lines: lines, totals: totals);
}
