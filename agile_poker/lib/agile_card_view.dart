import 'package:flutter/material.dart';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:agile_poker/data/model/agile_card.dart';

class AgileCardView extends StatelessWidget {
  final AgileCard _card;

  AgileCardView(this._card);

  factory AgileCardView.as(AgileCard card) {
    return AgileCardView(card);
  }

  factory AgileCardView.asNumber(int number, {String image}) {
    final card = AgileCard.asNew(id: 0, number: number, image: image);
    return  AgileCardView(card);
  }

  factory AgileCardView.asBlank() {
    return AgileCardView.asNumber(null);
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      child: _cardCenterDisplay(),
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
      child: Center(
        child: cardSize
      ),
      color: Colors.transparent,
    );
    return materialCard;
  }

  Widget _cardText() {
    final text = AutoSizeText('${_card.symbol}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
      minFontSize: 20,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontSize: 220
      ),
    );
    return Container(
      child: Center(
        child: text,
      ),
      margin: EdgeInsets.all(40),
    );
  }

  Widget _cardImage() {
    return Container(
      child: Opacity(
        opacity: 0.5,
        child: Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(
              width: 3,
              color: Colors.black87,
            ),
            image: DecorationImage(
              image: FileImage(File(_card.image)),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
      padding: EdgeInsets.all(30),
    );
  }

  Widget _cardCenterDisplay() {
    final displays =
      _card.image.isNotEmpty
      ? [_cardImage(), _cardText()]
      : [_cardText()];
    return Center(
      child: AspectRatio(
        child: Stack(
          children: displays,
        ),
        aspectRatio: 1.0,
      ),
    );
  }
}