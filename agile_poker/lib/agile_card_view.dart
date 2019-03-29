import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    final card = Container(
      child: _getCardText(),
      decoration: BoxDecoration(
        border: Border.all(width:3, color: Colors.black26),
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100],
      ),
    );
    final cardSize = AspectRatio(
      child: card,
      aspectRatio: 0.7,
    );
    final materialCard = Material(
      child: cardSize,
      color: Colors.transparent,
    );
    return materialCard;
  }

  Widget _getCardText() {
    final text = AutoSizeText('${_card.symbol ?? ''}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
      minFontSize: 10,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontSize: 260
      ),
    );
    final textContainer = Center(
      child: Container(
        child: text,
        margin: EdgeInsets.all(6),
      ),
    );
    return textContainer;
  }
}