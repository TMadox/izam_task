import 'package:flutter/material.dart';
import 'package:izam_task/src/catalog/constants/catalog_constants.dart';

class CatalogLoadingWidget extends StatelessWidget {
  const CatalogLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), SizedBox(height: CatalogConstants.spacing), Text('Loading catalog...')],
      ),
    );
  }
}
