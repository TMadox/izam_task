extension NumExtension on num {
  /// Returns the number formatted as a currency string with 2 decimal places and a dollar sign.
  /// Example: 12.5.money => "$12.50"
  String get money => '\$${toStringAsFixed(2)}';
}
