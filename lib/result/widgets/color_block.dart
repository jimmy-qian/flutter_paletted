import 'package:flutter/material.dart';

class ColorBlock extends StatelessWidget {
  const ColorBlock({required this.color, super.key});

  final String color;

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: hexToColor(color),
        child: Center(
          child: Text(color.toUpperCase()),
        ),
      ),
    );
  }
}
