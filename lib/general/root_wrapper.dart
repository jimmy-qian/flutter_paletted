import 'package:flutter/material.dart';

class RootWrapper extends StatelessWidget {
  RootWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: child),
    );
  }
}
