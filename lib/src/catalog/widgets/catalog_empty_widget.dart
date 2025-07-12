import 'package:flutter/material.dart';
import 'package:izam_task/src/catalog/constants/catalog_constants.dart';

class CatalogEmptyWidget extends StatelessWidget {
  const CatalogEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2, size: CatalogConstants.largeIconSize, color: CatalogConstants.primaryColor),
          const SizedBox(height: CatalogConstants.spacing),
          const Text('Product Catalog', style: CatalogConstants.titleStyle),
          const SizedBox(height: CatalogConstants.smallSpacing),
          const Text('Browse and select products', style: CatalogConstants.subtitleStyle),
        ],
      ),
    );
  }
}
