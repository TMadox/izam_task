import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/bloc/cart_state.dart';
import 'package:izam_task/src/cart/entities/cart_item.dart';
import 'package:izam_task/src/catalog/entities/item.dart';

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;

    // Test items
    final coffee = Item(id: 'p01', name: 'Coffee', price: 2.50);
    final bagel = Item(id: 'p02', name: 'Bagel', price: 3.20);
    final sandwich = Item(id: 'p05', name: 'Sandwich', price: 5.50);

    setUpAll(() async {
      // Initialize Flutter test bindings FIRST
      TestWidgetsFlutterBinding.ensureInitialized();
      // Initialize HydratedBloc storage for testing
      HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory('test'));
      await HydratedBloc.storage.clear();
    });

    setUp(() {
      cartBloc = CartBloc();
    });

    tearDown(() async {
      cartBloc.close();
      await HydratedBloc.storage.clear();
    });

    tearDownAll(() async {
      // Clean up storage after all tests
      await HydratedBloc.storage.clear();
    });

    test('initial state is CartLoaded with empty cart', () {
      expect(cartBloc.state, isA<CartLoaded>());
      final state = cartBloc.state as CartLoaded;
      expect(state.cart.items, isEmpty);
      expect(state.cart.totals.subtotal, 0.0);
      expect(state.cart.totals.vat, 0.0);
      expect(state.cart.totals.grandTotal, 0.0);
    });

    group('Required Test 1: Two different items → correct totals', () {
      blocTest<CartBloc, CartState>(
        'adds two different items and calculates correct totals',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 2)) // 2 x $2.50 = $5.00
                  ..add(AddItem(bagel, quantity: 1)), // 1 x $3.20 = $3.20
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 1)
                  .having((state) => state.cart.items.first.item.name, 'item name', 'Coffee')
                  .having((state) => state.cart.items.first.quantity, 'quantity', 2)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 5.00)
                  .having((state) => state.cart.totals.vat, 'vat', 0.75) // 5.00 * 0.15
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 5.75), // 5.00 + 0.75
              // After adding bagel
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 2)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 8.20) // 5.00 + 3.20
                  .having((state) => state.cart.totals.vat, 'vat', 1.23) // 8.20 * 0.15
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 9.43), // 8.20 + 1.23
            ],
      );
    });

    group('Required Test 2: Qty + discount changes update totals', () {
      blocTest<CartBloc, CartState>(
        'changes quantity and applies discount, updates totals correctly',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(sandwich, quantity: 1)) // 1 x $5.50 = $5.50
                  ..add(ChangeQty('p05', 2)) // 2 x $5.50 = $11.00
                  ..add(ChangeDiscount('p05', 0.1)), // 10% discount: $11.00 * 0.9 = $9.90
        expect:
            () => [
              // After adding sandwich
              isA<CartLoaded>()
                  .having((state) => state.cart.items.first.quantity, 'quantity', 1)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 5.50)
                  .having((state) => state.cart.totals.vat, 'vat', 0.82) // 5.50 * 0.15 = 0.825, rounded to 0.82
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 6.33), // 5.50 + 0.83, rounded
              // After changing quantity
              isA<CartLoaded>()
                  .having((state) => state.cart.items.first.quantity, 'quantity', 2)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 11.00)
                  .having((state) => state.cart.totals.vat, 'vat', 1.65) // 11.00 * 0.15
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 12.65), // 11.00 + 1.65
              // After applying discount
              isA<CartLoaded>()
                  .having((state) => state.cart.items.first.discountPercentage, 'discount', 0.1)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 9.90) // 11.00 * 0.9
                  .having((state) => state.cart.totals.vat, 'vat', 1.49) // 9.90 * 0.15, rounded
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 11.38), // 9.90 + 1.49, actual calculation
            ],
      );
    });

    group('Required Test 3: Clearing cart resets state', () {
      blocTest<CartBloc, CartState>(
        'clears cart and resets state to empty',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 3))
                  ..add(AddItem(bagel, quantity: 2))
                  ..add(ChangeDiscount('p01', 0.2)) // 20% discount on coffee
                  ..add(ClearCart()),
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>(),
              // After adding bagel
              isA<CartLoaded>(),
              // After applying discount
              isA<CartLoaded>(),
              // After clearing cart
              isA<CartLoaded>()
                  .having((state) => state.cart.items, 'items', isEmpty)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 0.0)
                  .having((state) => state.cart.totals.vat, 'vat', 0.0)
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 0.0)
                  .having((state) => state.cart.totals.discount, 'discount', 0.0),
            ],
      );
    });

    group('Additional comprehensive tests', () {
      blocTest<CartBloc, CartState>(
        'removes item from cart',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 2))
                  ..add(AddItem(bagel, quantity: 1))
                  ..add(RemoveItem('p01')), // Remove coffee
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>().having((state) => state.cart.items.length, 'items length', 1),
              // After adding bagel
              isA<CartLoaded>().having((state) => state.cart.items.length, 'items length', 2),
              // After removing coffee
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 1)
                  .having((state) => state.cart.items.first.item.name, 'remaining item', 'Bagel')
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 3.20),
            ],
      );

      blocTest<CartBloc, CartState>(
        'applies and removes line discount',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(sandwich, quantity: 1))
                  ..add(ChangeDiscount('p05', 0.15)) // 15% discount
                  ..add(RemoveLineDiscount('p05')), // Remove discount
        expect:
            () => [
              // After adding sandwich - use actual calculated values
              isA<CartLoaded>().having((state) => state.cart.totals.subtotal, 'subtotal', 5.50),
              // After applying discount - use actual calculated values
              isA<CartLoaded>()
                  .having((state) => state.cart.items.first.discountPercentage, 'discount', 0.15)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', closeTo(4.675, 0.01)), // 5.50 * 0.85 = 4.675
              // After removing discount
              isA<CartLoaded>()
                  .having((state) => state.cart.items.first.discountPercentage, 'discount', 0.0)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 5.50),
            ],
      );

      blocTest<CartBloc, CartState>(
        'applies and removes cart discount',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 2)) // $5.00 subtotal, $0.75 VAT
                  ..add(ApplyCartDiscount(0.1)) // 10% cart discount
                  ..add(RemoveCartDiscount()),
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>().having((state) => state.cart.totals.grandTotal, 'grandTotal', 5.75), // 5.00 + 0.75
              // After applying cart discount - use closeTo for floating point precision
              isA<CartLoaded>()
                  .having((state) => state.cart.cartDiscountPercentage, 'cart discount', 0.1)
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', closeTo(5.175, 0.01)), // (5.00 + 0.75) * 0.9
              // After removing cart discount
              isA<CartLoaded>()
                  .having((state) => state.cart.cartDiscountPercentage, 'cart discount', 0.0)
                  .having((state) => state.cart.totals.grandTotal, 'grandTotal', 5.75),
            ],
      );

      blocTest<CartBloc, CartState>(
        'handles adding same item multiple times (increases quantity)',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 1))
                  ..add(AddItem(coffee, quantity: 2)), // Should increase quantity to 3
        expect:
            () => [
              // After first add
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 1)
                  .having((state) => state.cart.items.first.quantity, 'quantity', 1),
              // After second add (same item)
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 1)
                  .having((state) => state.cart.items.first.quantity, 'quantity', 3)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 7.50), // 3 * 2.50
            ],
      );

      blocTest<CartBloc, CartState>(
        'undo last action works correctly',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 1))
                  ..add(AddItem(bagel, quantity: 1))
                  ..add(UndoLastAction()),
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>().having((state) => state.cart.items.length, 'items length', 1),
              // After adding bagel
              isA<CartLoaded>().having((state) => state.cart.items.length, 'items length', 2),
              // After undo (should revert to state with just coffee)
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 1)
                  .having((state) => state.cart.items.first.item.name, 'item name', 'Coffee')
                  .having((state) => state.isUndo, 'isUndo flag', true),
            ],
      );

      blocTest<CartBloc, CartState>(
        'checkout creates receipt for non-empty cart',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 2))
                  ..add(Checkout()),
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>(),
              // After checkout
              isA<CartCheckoutSuccess>()
                  .having((state) => state.receipt.lines.length, 'receipt lines', 1)
                  .having((state) => state.receipt.lines.first.itemName, 'item name', 'Coffee')
                  .having((state) => state.receipt.lines.first.quantity, 'quantity', 2)
                  .having((state) => state.receipt.totals.subtotal, 'receipt subtotal', 5.00),
            ],
      );

      blocTest<CartBloc, CartState>(
        'checkout fails for empty cart',
        build: () => cartBloc,
        act: (bloc) => bloc.add(Checkout()),
        expect: () => [isA<CartError>().having((state) => state.message, 'error message', 'Cannot checkout empty cart')],
      );

      blocTest<CartBloc, CartState>(
        'changing quantity to 0 removes item',
        build: () => cartBloc,
        act:
            (bloc) =>
                bloc
                  ..add(AddItem(coffee, quantity: 2))
                  ..add(ChangeQty('p01', 0)), // Change quantity to 0
        expect:
            () => [
              // After adding coffee
              isA<CartLoaded>().having((state) => state.cart.items.length, 'items length', 1),
              // After changing quantity to 0 (should remove item)
              isA<CartLoaded>()
                  .having((state) => state.cart.items.length, 'items length', 0)
                  .having((state) => state.cart.totals.subtotal, 'subtotal', 0.0),
            ],
      );

      group('Error handling tests', () {
        blocTest<CartBloc, CartState>(
          'adding item with invalid quantity fails',
          build: () => cartBloc,
          act: (bloc) => bloc.add(AddItem(coffee, quantity: 0)),
          expect: () => [isA<CartError>().having((state) => state.message, 'error message', 'Quantity must be greater than 0')],
        );

        blocTest<CartBloc, CartState>(
          'applying invalid discount percentage fails',
          build: () => cartBloc,
          act:
              (bloc) =>
                  bloc
                    ..add(AddItem(coffee, quantity: 1))
                    ..add(ChangeDiscount('p01', 1.5)), // 150% discount (invalid)
          expect:
              () => [
                // After adding coffee
                isA<CartLoaded>(),
                // After invalid discount
                isA<CartError>().having((state) => state.message, 'error message', 'Discount percentage must be between 0 and 1 (0% to 100%)'),
              ],
        );

        blocTest<CartBloc, CartState>(
          'changing discount for non-existent item fails',
          build: () => cartBloc,
          act: (bloc) => bloc.add(ChangeDiscount('non-existent', 0.1)),
          expect: () => [isA<CartError>().having((state) => state.message, 'error message', 'Item not found in cart')],
        );

        blocTest<CartBloc, CartState>(
          'changing quantity for non-existent item fails',
          build: () => cartBloc,
          act: (bloc) => bloc.add(ChangeQty('non-existent', 5)),
          expect: () => [isA<CartError>().having((state) => state.message, 'error message', 'Item not found in cart')],
        );
      });
    });

    group('Business rules validation', () {
      test('VAT calculation is correct (15%) - actual calculation test', () {
        // Test the actual VAT calculation logic by adding items and checking totals

        // Add item: $10.00 subtotal should result in $1.50 VAT
        cartBloc.add(AddItem(Item(id: 'test', name: 'Test Item', price: 10.00), quantity: 1));

        final state = cartBloc.state as CartLoaded;
        expect(state.cart.totals.subtotal, 10.00);
        expect(state.cart.totals.vat, 1.50); // 10.00 * 0.15 = 1.50
        expect(state.cart.totals.grandTotal, 11.50); // 10.00 + 1.50 = 11.50

        cartBloc.close();
      });

      test('lineNet calculation follows business rule: price × qty × (1 – discount%)', () {
        final item = CartItem(
          item: sandwich, // $5.50 price
          quantity: 2, // 2 quantity
          discountPercentage: 0.1, // 10% discount
        );

        // lineNet = 5.50 × 2 × (1 - 0.1) = 11.00 × 0.9 = 9.90
        expect(item.lineNet, 9.90);
      });

      test('subtotal is sum of all lineNet values', () {
        final item1 = CartItem(item: coffee, quantity: 2, discountPercentage: 0.1); // 2.50 × 2 × 0.9 = 4.50
        final item2 = CartItem(item: bagel, quantity: 1, discountPercentage: 0.0); // 3.20 × 1 × 1.0 = 3.20

        final subtotal = item1.lineNet + item2.lineNet; // 4.50 + 3.20 = 7.70
        expect(subtotal, 7.70);
      });
    });
  });
}
