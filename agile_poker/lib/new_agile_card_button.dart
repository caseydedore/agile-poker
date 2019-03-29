import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewAgileCardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final view = Container(
      child: Center(child: AutoSizeText(
        '+',
        style: TextStyle(
          fontSize: 250,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      )),
      decoration: BoxDecoration(
        border: Border.all(width:2, color: Colors.black26),
        borderRadius: BorderRadius.circular(4),
        color: Colors.greenAccent,
      ),
      height: 60,
      width: 60,
    );
    final center = Center(
      child: view,
    );
    return Material(child: center, color: Colors.transparent);
  }
}
