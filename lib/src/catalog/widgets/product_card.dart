import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/catalog/constants/catalog_constants.dart';
import 'package:izam_task/src/catalog/entities/item.dart';

class ProductCard extends StatelessWidget {
  final Item item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: CatalogConstants.cardElevation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(CatalogConstants.borderRadius)),
              ),
              child: Icon(Icons.inventory_2, size: CatalogConstants.iconSize, color: CatalogConstants.primaryColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(CatalogConstants.smallPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name, style: CatalogConstants.productNameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${item.price.toStringAsFixed(2)}', style: CatalogConstants.priceStyle),
                      IconButton(icon: const Icon(Icons.add_shopping_cart), onPressed: () => context.read<CartBloc>().add(AddItem(item))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
