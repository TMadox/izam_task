import 'package:izam_task/src/catalog/entities/item.dart';

abstract class CartEvent {}

/// Add item to cart - renamed from AddToCart to match task requirements
class AddItem extends CartEvent {
  final Item item;
  final int quantity;

  AddItem(this.item, {this.quantity = 1});
}

/// Remove item from cart - renamed from RemoveFromCart to match task requirements
class RemoveItem extends CartEvent {
  final String itemId;

  RemoveItem(this.itemId);
}

/// Change quantity - renamed from UpdateQuantity to match task requirements
class ChangeQty extends CartEvent {
  final String itemId;
  final int quantity;

  ChangeQty(this.itemId, this.quantity);
}

/// Apply discount to a specific line item
class ChangeDiscount extends CartEvent {
  final String itemId;
  final double discountPercentage;

  ChangeDiscount(this.itemId, this.discountPercentage);
}

/// Remove discount from a specific line item
class RemoveLineDiscount extends CartEvent {
  final String itemId;

  RemoveLineDiscount(this.itemId);
}

/// Apply cart-wide discount (additional functionality)
class ApplyCartDiscount extends CartEvent {
  final double discountPercentage;
  ApplyCartDiscount(this.discountPercentage);
}

/// Remove cart-wide discount (additional functionality)
class RemoveCartDiscount extends CartEvent {}

/// Clear all items from cart
class ClearCart extends CartEvent {
  final bool isUndo;
  ClearCart({this.isUndo = false});
}

/// Undo last action (nice-to-have feature)
class UndoLastAction extends CartEvent {}

/// Checkout and generate receipt
class Checkout extends CartEvent {}
