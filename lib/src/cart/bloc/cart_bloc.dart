import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/bloc/cart_state.dart';
import 'package:izam_task/src/cart/entities/cart.dart';
import 'package:izam_task/src/cart/entities/cart_item.dart';
import 'package:izam_task/src/cart/entities/cart_totals.dart';
import 'package:izam_task/src/cart/entities/receipt.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  /// VAT rate as specified in requirements: 15%
  static const double _vatRate = 0.15;

  CartState? _previousState;

  CartBloc() : super(CartLoaded(Cart(items: [], totals: CartTotals()))) {
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<ChangeQty>(_onChangeQty);
    on<ChangeDiscount>(_onChangeDiscount);
    on<RemoveLineDiscount>(_onRemoveLineDiscount);
    on<ApplyCartDiscount>(_onApplyCartDiscount);
    on<RemoveCartDiscount>(_onRemoveCartDiscount);
    on<ClearCart>(_onClearCart);
    on<UndoLastAction>(_onUndoLastAction);
    on<Checkout>(_onCheckout);
  }

  @override
  void onTransition(Transition<CartEvent, CartState> transition) {
    // Only save undo state for mutating events (not for undo itself)
    if (transition.event is! UndoLastAction && transition.event is! Checkout && transition.currentState is CartLoaded) {
      _previousState = transition.currentState;
    }
    super.onTransition(transition);
  }

  Future<void> _onUndoLastAction(UndoLastAction event, Emitter<CartState> emit) async {
    if (_previousState != null && _previousState is CartLoaded) {
      emit((_previousState! as CartLoaded).copyWith(isUndo: true));
      _previousState = null;
    }
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['type'] == 'CartLoaded') {
        final cart = Cart.fromJson(json['cart'] as Map<String, dynamic>);
        return CartLoaded(cart);
      }
      return CartLoaded(Cart(items: [], totals: CartTotals()));
    } catch (e) {
      return CartLoaded(Cart(items: [], totals: CartTotals()));
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartLoaded) {
      return {'type': 'CartLoaded', 'cart': state.cart.toJson()};
    }
    return {'type': 'CartInitial'};
  }

  void _onAddItem(AddItem event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    // Validate quantity
    if (event.quantity <= 0) {
      emit(CartError('Quantity must be greater than 0'));
      return;
    }

    final currentItems = List<CartItem>.from(currentState.cart.items);
    final existingItemIndex = currentItems.indexWhere((cartItem) => cartItem.item.id == event.item.id);

    if (existingItemIndex != -1) {
      // Update existing item quantity
      currentItems[existingItemIndex] = currentItems[existingItemIndex].copyWith(quantity: currentItems[existingItemIndex].quantity + event.quantity);
    } else {
      // Add new item
      currentItems.add(CartItem(item: event.item, quantity: event.quantity));
    }

    final totals = _calculateTotals(currentItems, currentState.cart.cartDiscountPercentage);
    emit(CartLoaded(Cart(items: currentItems, totals: totals, cartDiscountPercentage: currentState.cart.cartDiscountPercentage)));
  }

  void _onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    final currentItems = List<CartItem>.from(currentState.cart.items);
    currentItems.removeWhere((cartItem) => cartItem.item.id == event.itemId);

    final totals = _calculateTotals(currentItems, currentState.cart.cartDiscountPercentage);
    emit(CartLoaded(Cart(items: currentItems, totals: totals, cartDiscountPercentage: currentState.cart.cartDiscountPercentage)));
  }

  void _onChangeQty(ChangeQty event, Emitter<CartState> emit) {
    if (event.quantity <= 0) {
      _onRemoveItem(RemoveItem(event.itemId), emit);
      return;
    }

    final currentState = state;
    if (currentState is! CartLoaded) return;

    final currentItems = List<CartItem>.from(currentState.cart.items);
    final itemIndex = currentItems.indexWhere((cartItem) => cartItem.item.id == event.itemId);

    if (itemIndex == -1) {
      emit(CartError('Item not found in cart'));
      return;
    }

    currentItems[itemIndex] = currentItems[itemIndex].copyWith(quantity: event.quantity);
    final totals = _calculateTotals(currentItems, currentState.cart.cartDiscountPercentage);
    emit(CartLoaded(Cart(items: currentItems, totals: totals, cartDiscountPercentage: currentState.cart.cartDiscountPercentage)));
  }

  void _onChangeDiscount(ChangeDiscount event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    // Validate discount percentage
    if (event.discountPercentage < 0 || event.discountPercentage > 1) {
      emit(CartError('Discount percentage must be between 0 and 1 (0% to 100%)'));
      return;
    }

    final currentItems = List<CartItem>.from(currentState.cart.items);
    final itemIndex = currentItems.indexWhere((cartItem) => cartItem.item.id == event.itemId);

    if (itemIndex == -1) {
      emit(CartError('Item not found in cart'));
      return;
    }

    currentItems[itemIndex] = currentItems[itemIndex].copyWith(discountPercentage: event.discountPercentage);
    final totals = _calculateTotals(currentItems, currentState.cart.cartDiscountPercentage);
    emit(CartLoaded(Cart(items: currentItems, totals: totals, cartDiscountPercentage: currentState.cart.cartDiscountPercentage)));
  }

  void _onRemoveLineDiscount(RemoveLineDiscount event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    final currentItems = List<CartItem>.from(currentState.cart.items);
    final itemIndex = currentItems.indexWhere((cartItem) => cartItem.item.id == event.itemId);

    if (itemIndex == -1) {
      emit(CartError('Item not found in cart'));
      return;
    }

    currentItems[itemIndex] = currentItems[itemIndex].copyWith(discountPercentage: 0.0);
    final totals = _calculateTotals(currentItems, currentState.cart.cartDiscountPercentage);
    emit(CartLoaded(Cart(items: currentItems, totals: totals, cartDiscountPercentage: currentState.cart.cartDiscountPercentage)));
  }

  void _onApplyCartDiscount(ApplyCartDiscount event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    // Validate discount percentage
    if (event.discountPercentage < 0 || event.discountPercentage > 1) {
      emit(CartError('Cart discount percentage must be between 0 and 1 (0% to 100%)'));
      return;
    }

    final updatedCart = currentState.cart.copyWith(cartDiscountPercentage: event.discountPercentage);
    final totals = _calculateTotals(updatedCart.items, updatedCart.cartDiscountPercentage);
    emit(CartLoaded(updatedCart.copyWith(totals: totals)));
  }

  void _onRemoveCartDiscount(RemoveCartDiscount event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    final updatedCart = currentState.cart.copyWith(cartDiscountPercentage: 0.0);
    final totals = _calculateTotals(updatedCart.items, updatedCart.cartDiscountPercentage);
    emit(CartLoaded(updatedCart.copyWith(totals: totals)));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartLoaded(Cart(items: [], totals: CartTotals()), isUndo: event.isUndo));
  }

  void _onCheckout(Checkout event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is! CartLoaded) return;

    if (currentState.cart.items.isEmpty) {
      emit(CartError('Cannot checkout empty cart'));
      return;
    }

    try {
      final receipt = buildReceipt(currentState.cart, DateTime.now());
      emit(CartCheckoutSuccess(receipt));
    } catch (e) {
      emit(CartError('Failed to process checkout: ${e.toString()}'));
    }
  }

  /// Calculate totals according to business rules:
  /// - lineNet = price × qty × (1 – discount%) (per line)
  /// - subtotal = Σ lineNet
  /// - vat = subtotal × 0.15 (VAT calculated on subtotal, not after cart discount)
  /// - grandTotal = subtotal + vat - cartDiscount
  CartTotals _calculateTotals(List<CartItem> items, [double cartDiscountPercentage = 0.0]) {
    // subtotal = Σ lineNet (sum of all line net amounts after item discounts)
    final subtotal = items.fold(0.0, (sum, item) => sum + item.lineNet);

    // vat = subtotal × 0.15 (VAT calculated on subtotal before cart discount)
    final vat = subtotal * _vatRate;

    // Cart discount is applied to the subtotal + vat
    final subtotalWithVat = subtotal + vat;
    final cartDiscount = subtotalWithVat * cartDiscountPercentage;

    // grandTotal = subtotal + vat - cartDiscount
    final grandTotal = subtotalWithVat - cartDiscount;

    // Calculate total discount amount for display purposes
    // This includes both item-level discounts and cart-level discount
    final totalWithoutAnyDiscount = items.fold(0.0, (sum, item) => sum + (item.item.price * item.quantity));
    final itemDiscounts = totalWithoutAnyDiscount - subtotal;
    final totalDiscount = itemDiscounts + cartDiscount;

    return CartTotals(
      subtotal: _roundToTwoDecimals(subtotal),
      vat: _roundToTwoDecimals(vat),
      grandTotal: _roundToTwoDecimals(grandTotal),
      discount: _roundToTwoDecimals(totalDiscount),
    );
  }

  /// Helper method to round values to 2 decimal places
  /// Using the acceptable rounding method from task hints
  double _roundToTwoDecimals(double value) {
    return double.parse(value.toStringAsFixed(2));
  }
}
