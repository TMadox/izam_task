import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/catalog/bloc/catalog_bloc.dart';
import 'package:izam_task/src/catalog/bloc/catalog_event.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<CatalogBloc>(create: (context) => CatalogBloc()..add(LoadCatalog())),
      ],
      child: child,
    );
  }
}
