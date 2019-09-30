import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'agile_card_view.dart';
import 'data/model/agile_card.dart';
import 'package:agile_poker/service/deck_provider.dart';

class DeckView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deckState = Provider.of<DeckProvider>(context);
    final cards = deckState.cards;
    return Column(
      children: [
        Expanded(child: _buildInteractiveDeck(deckState: deckState, cards: cards))
      ]
    );
  }

  static Widget _getViewForExistingCard(AgileCard card) {
    final view = AgileCardView.as(card);
    final container = Container(
      child: view,
      margin: EdgeInsets.all(10),
    );
    return GestureDetector(
      child: container,
    );
  }

  Widget _buildInteractiveDeck({DeckRootState deckState, List<AgileCard> cards}) {
    final cardViews = cards.map((card) => _getViewForExistingCard(card)).toList();
    final cardList = PageView(
      scrollDirection: Axis.horizontal,
      children: cardViews,
      pageSnapping: false,
    );
    var isScrollingToRest = false;
    return Container(
      child: NotificationListener(
        child: Scrollbar(child: cardList),
        onNotification: (notification) {
          if (!isScrollingToRest && notification is ScrollEndNotification) {
            isScrollingToRest = true;
            final cardWidth = _getItemOffsetFactor(
              maxScrollExtent: cardList.controller.position.maxScrollExtent,
              numItems: cardViews.length
            );
            final cardPositions = cardViews.map(
              (widget) => (cardViews.indexOf(widget) + 1) * cardWidth
            ).toList();
            final closestPage = _getClosestPage(
              position: cardList.controller.offset,
              values: cardPositions
            );
            _scrollToPage(controller: cardList.controller, page: closestPage)
              .then((result) {
                isScrollingToRest = false;
                deckState.currentCard = cards[closestPage];
            });
          }
        },
      ),
    );
  }

  Future _scrollToPage({PageController controller, int page}) async {
    await Future.delayed(Duration(milliseconds: 10));
    controller.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  int _getClosestPage({double position, List<double> values}) {
    double closest = 0;
    values.forEach((value) {
      final differenceToTarget = (position - value).abs();
      final differenceToPotential = (position - closest).abs();
      if (differenceToTarget < differenceToPotential) {
        closest = value;
      }
      else return;
    });
    return values.indexOf(closest) + 1;
  }

  double _getItemOffsetFactor({double maxScrollExtent, int numItems}) {
    if (numItems <= 1) {
      return 0;
    }
    final singleItemOuterBound = maxScrollExtent / (numItems - 1);
    return singleItemOuterBound;
  }
}