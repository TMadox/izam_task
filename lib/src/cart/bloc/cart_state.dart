// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:izam_task/src/cart/entities/cart.dart';
import 'package:izam_task/src/cart/entities/receipt.dart';

abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final Cart cart;
  final bool isUndo;
  CartLoaded(this.cart, {this.isUndo = false});

  @override
  List<Object?> get props => [cart, isUndo];

  CartLoaded copyWith({Cart? cart, bool? isUndo}) => CartLoaded(cart ?? this.cart, isUndo: isUndo ?? this.isUndo);
}

class CartCheckoutSuccess extends CartState {
  final Receipt receipt;

  CartCheckoutSuccess(this.receipt);

  @override
  List<Object?> get props => [receipt];
}

class CartError extends CartState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}
