import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardDismissWrapper extends StatelessWidget {
  final Widget child;

  const KeyboardDismissWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside of text fields
        FocusScope.of(context).unfocus();
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: child,
    );
  }
}
