import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BottomSheetBarController bottomSheetController;

  const CartAppBar({super.key, required this.bottomSheetController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          FocusScope.of(context).unfocus();
          bottomSheetController.collapse();
        },
      ),
      title: const Text('Shopping Cart'),
      backgroundColor: CartConstants.primaryColor,
      foregroundColor: Colors.white,
      actions: [IconButton(icon: const Icon(Icons.clear_all), onPressed: () => context.read<CartBloc>().add(ClearCart()))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
