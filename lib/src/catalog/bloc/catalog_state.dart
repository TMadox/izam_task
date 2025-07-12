import '../entities/item.dart';

abstract class CatalogState {}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Item> items;
  CatalogLoaded(this.items);
}

class CatalogError extends CatalogState {
  final String message;
  CatalogError(this.message);
}
