import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/app/extensions/num_extension.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';
import 'package:izam_task/src/cart/constants/cart_constants.dart';
import 'package:izam_task/src/cart/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: CartConstants.smallSpacing),
      child: ListTile(
        leading: Container(
          width: CartConstants.itemImageSize,
          height: CartConstants.itemImageSize,
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(CartConstants.borderRadius)),
          child: const Icon(Icons.inventory_2, color: CartConstants.primaryColor),
        ),
        title: Text(cartItem.item.name, style: CartConstants.itemNameStyle),
        subtitle: Text('${cartItem.item.price.money} each'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (cartItem.quantity > 1) {
                  context.read<CartBloc>().add(ChangeQty(cartItem.item.id, cartItem.quantity - 1));
                } else {
                  context.read<CartBloc>().add(RemoveItem(cartItem.item.id));
                }
              },
            ),
            Text('${cartItem.quantity}'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.read<CartBloc>().add(ChangeQty(cartItem.item.id, cartItem.quantity + 1));
              },
            ),
            const SizedBox(width: CartConstants.smallSpacing),
            Text(cartItem.totalPrice.money, style: CartConstants.priceStyle),
          ],
        ),
      ),
    );
  }
}
