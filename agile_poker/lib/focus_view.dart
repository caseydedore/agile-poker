import 'package:flutter/material.dart';

class FocusView extends StatelessWidget {
  final Widget child;

  FocusView(this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }
}