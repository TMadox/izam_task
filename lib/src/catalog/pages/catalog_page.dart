import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/catalog/bloc/catalog_bloc.dart';
import 'package:izam_task/src/catalog/bloc/catalog_state.dart';
import 'package:izam_task/src/catalog/widgets/index.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder:
            (context, state) => switch (state) {
              CatalogLoading() => const CatalogLoadingWidget(),
              CatalogError() => CatalogErrorWidget(message: state.message),
              CatalogLoaded() => CatalogContent(items: state.items),
              _ => const CatalogEmptyWidget(),
            },
      ),
    );
  }
}
