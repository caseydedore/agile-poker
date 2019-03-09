import 'package:flutter/material.dart';
import 'dart:math';

class AgileCard extends StatelessWidget {
  AgileCard.asBlank();

  @override
  Widget build(BuildContext context) {
    final random = Random();
    var width = 300.0;
    final margin = EdgeInsets.all(20.0);
    final card01 = 'https://allaboutcards.files.wordpress.com/2009/07/queen-diamonds.png';
    final card02 = 'https://allaboutcards.files.wordpress.com/2009/06/jack-spades.png';
    final card03 = 'https://allaboutcards.files.wordpress.com/2009/07/bp-frogace.jpg';
    final cards = [card01, card02, card03];
    final pick = cards.elementAt(random.nextInt(cards.length));
    return new Container(
        width: width,
        child: Image.network(pick, fit: BoxFit.contain),
        margin: margin
    );
  }
}