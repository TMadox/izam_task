import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/app/utils/screen_size_helpers.dart';
import 'package:izam_task/shared/widgets/cart_bottom_bar.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_state.dart';
import 'package:izam_task/src/cart/pages/cart_page.dart';
import 'package:izam_task/src/catalog/constants/catalog_constants.dart';
import 'package:izam_task/src/catalog/entities/item.dart';
import 'package:izam_task/src/catalog/widgets/catalog_grid.dart';

class CatalogContent extends StatefulWidget {
  final List<Item> items;

  const CatalogContent({super.key, required this.items});

  @override
  State<CatalogContent> createState() => _CatalogContentState();
}

class _CatalogContentState extends State<CatalogContent> {
  final _bottomSheetController = BottomSheetBarController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => current is! CartCheckoutSuccess,
      builder: (context, cartState) {
        if (cartState is CartLoaded) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: cartState.cart.items.isNotEmpty ? context.screenHeight * 0.10 : 0),
            duration: CatalogConstants.animationDuration,
            curve: CatalogConstants.animationCurve,
            builder:
                (context, animatedHeight, child) => BottomSheetBar(
                  controller: _bottomSheetController,
                  collapsed: CartBottomBar(controller: _bottomSheetController, cart: cartState.cart),
                  height: animatedHeight,
                  expandedBuilder: (scrollController) => CartPage(cart: cartState.cart, bottomSheetController: _bottomSheetController),
                  body: Scaffold(
                    appBar: AppBar(title: const Text('Catalog'), backgroundColor: CatalogConstants.primaryColor, foregroundColor: Colors.white),
                    body: CatalogGrid(items: widget.items),
                  ),
                ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
