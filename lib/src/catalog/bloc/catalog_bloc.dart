import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:izam_task/src/catalog/bloc/catalog_event.dart';
import 'package:izam_task/src/catalog/bloc/catalog_state.dart';

import '../entities/item.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<LoadCatalog>(_onLoadCatalog);
  }

  Future<void> _onLoadCatalog(LoadCatalog event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    try {
      final String response = await rootBundle.loadString('assets/catalog.json');
      final List<dynamic> itemsJson = jsonDecode(response);
      final List<Item> items = itemsJson.map((json) => Item.fromJson(json)).toList();
      emit(CatalogLoaded(items));
    } catch (e) {
      emit(CatalogError('Failed to load catalog: $e'));
    }
  }
}
