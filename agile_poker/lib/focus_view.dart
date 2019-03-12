
import 'package:flutter/material.dart';
import 'agile_card_view.dart';

class FocusView extends StatelessWidget {
  final AgileCardView _card;

  FocusView(this._card);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _card,
    );
  }
}