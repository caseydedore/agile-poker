import 'package:flutter/material.dart';
import 'agile_card_view.dart';
import 'card-action-view.dart';
import 'agile_card_edit_view.dart';
import 'new_agile_card_button.dart';
import 'data/agile_card_data.dart';
import 'data/model/agile_card.dart';

class DeckView extends StatefulWidget {
  DeckView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DeckViewState createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  int _cardIndex = 0;
  List<Widget> _cards;
  List<AgileCard> _agileCards;
  CardActionView _cardAction;
  final _data = AgileCardData();

  @override
  void initState() {
    _updateData();
    super.initState();
  }

  void _updateData() {
    _data.getAgileCards().then((agileCards) {
      setState(() {
        _agileCards = agileCards;
        final newCardWidget = _getViewForNewCard();
        final cardWidgets =
          _agileCards.map((card) => _getViewForExistingCard(card)).toList();
        cardWidgets.add(newCardWidget);
        _cards = cardWidgets;
        var _navItems =
            _agileCards.map((card) => card.symbol.toString()).toList();
        _navItems.add('+');
        _cardAction.setCards(_navItems);
        _cardAction.update(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _cardAction = CardActionView(
      _editCard,
      _deleteCard
    );
    final cardList = PageView(
      scrollDirection: Axis.horizontal,
      children: _cards ?? [],
      pageSnapping: true,
      onPageChanged: (index) {
        setState(() {
          _cardIndex = index;
          _cardAction.update(_cardIndex);
        });
      }
    );
    final card = Container(
      child: cardList,
    );
    final deck = Column(
      children: <Widget>[
        Expanded(
          child: card
        ),
        Container(
          child: Center(
            child: _cardAction
          ),
          height: 120,
        )
      ]
    );
    return Material(
      child: deck,
      color: Colors.white,
    );
  }

  Widget _getViewForExistingCard(AgileCard card) {
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

  void _editCard() {
    final card = _agileCards[_cardIndex];
    final editView = AgileCardEditView(card, _updateData);
    final cardEditRoute = MaterialPageRoute(builder: (context) => editView);
    Navigator.push(context, cardEditRoute);
  }

  void _deleteCard() async {
    await _data.removeAgileCard(_agileCards[_cardIndex]);
    _updateData();
  }

  Widget _getViewForNewCard() {
    final container = Container(
      child: NewAgileCardButton(),
      margin: EdgeInsets.all(10),
    );
    final gesture = GestureDetector(
      child: container,
      onLongPress: () async {
        await _data.addAgileCard(AgileCard(0, 0));
        _updateData();
      },
    );
    return gesture;
  }
}