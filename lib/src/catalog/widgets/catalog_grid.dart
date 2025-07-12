import 'package:flutter/material.dart';
import 'package:izam_task/src/catalog/constants/catalog_constants.dart';
import 'package:izam_task/src/catalog/entities/item.dart';
import 'package:izam_task/src/catalog/widgets/product_card.dart';

class CatalogGrid extends StatelessWidget {
  final List<Item> items;

  const CatalogGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(CatalogConstants.padding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: CatalogConstants.crossAxisCount,
        childAspectRatio: CatalogConstants.childAspectRatio,
        crossAxisSpacing: CatalogConstants.crossAxisSpacing,
        mainAxisSpacing: CatalogConstants.mainAxisSpacing,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(item: item);
      },
    );
  }
}
