import 'package:flutter/material.dart';
import 'package:agile_poker/data/model/agile_card.dart';

class AgileCardView extends StatelessWidget {
  final AgileCard _card;

  AgileCardView(this._card);

  factory AgileCardView.as(AgileCard card) {
    return AgileCardView(card);
  }

  factory AgileCardView.asNumber(int number) {
    final card = AgileCard(0, number);
    return  AgileCardView(card);
  }

  factory AgileCardView.asBlank() {
    return AgileCardView.asNumber(null);
  }

  @override
  Widget build(BuildContext context) {
    final width = 300.0;
    final height = 450.0;
    final margin = EdgeInsets.all(20.0);
    final card = Container(
      width: width,
      height: height,
      child: _getCardText(),
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(width:3, color: Colors.black26),
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100],
      ),
    );
    final materialCard = Material(
      child: card,
      color: Colors.transparent,
    );
    return materialCard;
  }

  Widget _getCardText() {
    final text = Text('${_card.number ?? ''}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 180,
        color: Colors.black87
      ),
    );
    final textContainer = Center(
      child: text,
    );
    return textContainer;
  }
}