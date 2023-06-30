import 'package:flutter/material.dart';
import 'package:flutter_paletted/service/service.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({
    required this.onPressedCapture,
    super.key,
    this.variant = 'PRIMARY',
  });

  final String variant;
  final void Function() onPressedCapture;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(40),
        side: BorderSide(
          width: 6,
          color: hexToColor('#CCCCCC'),
        ),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressedCapture,
      child: null,
    );
  }
}
