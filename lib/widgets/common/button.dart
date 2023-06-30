import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    required this.label,
    this.onPressed,
    super.key,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor:
          variant == ButtonVariant.primary ? Colors.white : Colors.black,
      minimumSize: const Size.fromHeight(48),
      side: variant == ButtonVariant.primary
          ? null
          : const BorderSide(
              color: Colors.white,
            ),
    );

    final textStyle = const TextStyle().copyWith(
      color: variant == ButtonVariant.primary ? Colors.black : Colors.white,
    );

    return TextButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle,
      ),
    );
  }
}

enum ButtonVariant {
  primary,
  secondary,
}
