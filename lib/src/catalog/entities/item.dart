// To simplify the code, I'm using a simple entity class that contains the item's id, name, description, price, imageUrl, and category.
// I'm not using a separate item model class because it's not necessary for this task.

import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final double price;

  const Item({required this.id, required this.name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(id: json['id'] as String, name: json['name'] as String, price: (json['price'] as num).toDouble());

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'price': price};

  @override
  List<Object?> get props => [id, name, price];
}
