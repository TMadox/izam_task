import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izam_task/app/constants/app_constants.dart';
import 'package:izam_task/src/cart/bloc/cart_bloc.dart';
import 'package:izam_task/src/cart/bloc/cart_event.dart';

class UndoSnackBar {
  static SnackBar build(BuildContext context, VoidCallback onDismiss) {
    return SnackBar(
      width: AppConstants.snackbarWidth,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.snackbarBorderRadius)),
      elevation: AppConstants.snackbarElevation,
      padding: AppConstants.snackbarPadding,
      duration: AppConstants.snackbarDuration,
      backgroundColor: AppConstants.snackbarBackgroundColor,
      content: GestureDetector(
        onTap: () {
          context.read<CartBloc>().add(UndoLastAction());
          onDismiss();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular countdown
            SizedBox(
              width: AppConstants.progressSize,
              height: AppConstants.progressSize,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration: AppConstants.progressDuration,
                builder: (context, value, child) {
                  return CircularProgressIndicator(
                    value: value,
                    strokeWidth: AppConstants.progressStrokeWidth,
                    backgroundColor: AppConstants.progressBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(AppConstants.progressValueColor),
                  );
                },
              ),
            ),
            const SizedBox(width: AppConstants.spacing),
            Text('UNDO', style: AppConstants.snackbarTextStyle),
          ],
        ),
      ),
    );
  }
}
