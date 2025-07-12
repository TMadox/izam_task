import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/bloc/cart_state.dart';
import 'package:izam_task/src/cart/entities/cart.dart';
import 'package:izam_task/src/cart/widgets/index.dart';

class CartPage extends StatelessWidget {
  final Cart cart;
  final BottomSheetBarController bottomSheetController;

  const CartPage({super.key, required this.cart, required this.bottomSheetController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(bottomSheetController: bottomSheetController),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartCheckoutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.receipt.toString())));
            context.read<CartBloc>().add(ClearCart(isUndo: true));
          }
        },
        builder:
            (context, state) => switch (state) {
              CartInitial() => const CartLoadingWidget(),
              CartError() => CartErrorWidget(message: state.message),
              CartLoaded() => state.cart.items.isEmpty ? const CartEmptyWidget() : CartContent(cart: state.cart),
              _ => const CartLoadingWidget(),
            },
      ),
    );
  }
}
