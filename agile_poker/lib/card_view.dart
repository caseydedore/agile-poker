
import 'package:flutter/material.dart';
import 'agile_card.dart';

class CardView extends StatelessWidget {
  final AgileCard _card;

  CardView(this._card);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _card,
    );
  }
}