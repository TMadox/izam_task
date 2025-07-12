import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/shared/widgets/undo_snackbar.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_state.dart';

class CartListenerWrapper extends StatefulWidget {
  final Widget child;

  const CartListenerWrapper({super.key, required this.child});

  @override
  State<CartListenerWrapper> createState() => _CartListenerWrapperState();
}

class _CartListenerWrapperState extends State<CartListenerWrapper> {
  bool _snackBarActive = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded && !state.isUndo) {
          // Show undo snackbar when cart changes (except on undo itself)
          if (!_snackBarActive) {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            _snackBarActive = true;
            scaffoldMessenger
                .showSnackBar(UndoSnackBar.build(context, () => scaffoldMessenger.hideCurrentSnackBar()))
                .closed
                .then((_) => _snackBarActive = false);
          }
        }
      },
      child: widget.child,
    );
  }
}
