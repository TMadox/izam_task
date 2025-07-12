import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/catalog/bloc/catalog_bloc.dart';
import 'package:izam_task/src/catalog/bloc/catalog_event.dart';
import 'package:izam_task/src/catalog/constants/catalog_constants.dart';

class CatalogErrorWidget extends StatelessWidget {
  final String message;

  const CatalogErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: CatalogConstants.iconSize, color: CatalogConstants.errorColor),
          const SizedBox(height: CatalogConstants.spacing),
          Text(message, textAlign: TextAlign.center, style: CatalogConstants.errorTextStyle),
          const SizedBox(height: CatalogConstants.spacing),
          ElevatedButton(onPressed: () => context.read<CatalogBloc>().add(LoadCatalog()), child: const Text('Retry')),
        ],
      ),
    );
  }
}
