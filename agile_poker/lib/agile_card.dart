import 'package:flutter/material.dart';
import 'dart:math';

class AgileCard extends StatelessWidget {
  AgileCard.asBlank();

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    var _listWidth = 300.0;
    final _listMargin = EdgeInsets.all(20.0);
    final _card01 = 'https://allaboutcards.files.wordpress.com/2009/07/queen-diamonds.png';
    final _card02 = 'https://allaboutcards.files.wordpress.com/2009/06/jack-spades.png';
    final _card03 = 'https://allaboutcards.files.wordpress.com/2009/07/bp-frogace.jpg';
    final _cards = [_card01, _card02, _card03];
    final _cardPick = _cards.elementAt(_random.nextInt(_cards.length));
    return new Container(
        width: _listWidth,
        child: Image.network(_cardPick, fit: BoxFit.contain),
        margin: _listMargin
    );
  }
}