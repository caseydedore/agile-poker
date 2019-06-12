import 'package:flutter/material.dart';
import 'agile_card_view.dart';
import 'data/model/agile_card.dart';
import 'deck_root.dart';

class DeckView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deckState = DeckRoot.of(context);
    final cards = deckState.cards;
    final views = cards.map((card) => _getViewForExistingCard(card)).toList();
    final initialIndex = () {
      final index = cards.indexOf(deckState.currentCard);
      return index >= 0 ? index : 0;
    }();
    final cardList = PageView(
      scrollDirection: Axis.horizontal,
      children: views,
      pageSnapping: true,
      onPageChanged: (index) {
        deckState.currentCard = cards[index];
      },
      controller: PageController(
        initialPage: initialIndex,
        keepPage: false,
      ),
    );
    final card = Container(
      child: cardList
    );
    final deck = Column(
      children: <Widget>[
        Expanded(
          child: card
        ),
      ]
    );
    return deck;
  }

  static Widget _getViewForExistingCard(AgileCard card) {
    final view = AgileCardView.as(card);
    final container = Container(
      child: view,
      margin: EdgeInsets.all(10),
    );
    final gesture = GestureDetector(
      child: container,
    );
    return gesture;
  }
}