import 'package:flutter/material.dart';
import 'agile_card_view.dart';
import 'package:agile_poker/data/agile_card_data.dart';
import 'package:agile_poker/data/model/agile_card.dart';
import 'package:agile_poker/agile_card_edit_view.dart';
import 'package:agile_poker/new_agile_card_button.dart';

class Deck extends StatefulWidget {
  Deck({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  List<Widget> _cards;
  AgileCard _focus;
  final _data = AgileCardData();

  @override
  void initState() {
    _updateData();
    super.initState();
  }

  void _updateData() {
    _getCards().then((widgets) {
      setState(() {
        _cards = widgets;
        _focus = null;
      });
    });
  }

  void _setFocus(AgileCard card) {
    setState(() {
      _focus = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      child: _focus != null ? AgileCardView.as(_focus) : AgileCardView.asBlank(),
      margin: EdgeInsets.all(16),
    );
    final cardList = Scrollbar(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _cards ?? [],
        padding: EdgeInsets.symmetric(horizontal: 4),
      ),
    );
    final deck = Column(
      children: <Widget>[
        Expanded(
          child: card
        ),
        Container(
          child: cardList,
          height: 120,
        )
      ]
    );
    return Material(
      child: deck,
      color: Colors.white,
    );
  }

  Future<List<Widget>> _getCards() async {
    final cards = await _data.getAgileCards();
    final cardWidgets =
      cards.map((card) => _getViewForExistingCard(card)).toList();
    cardWidgets.add(_getViewForNewCard());
    return cardWidgets;
  }

  Widget _getViewForExistingCard (AgileCard card) {
    final view = AgileCardView.as(card);
    final container = Container(
      child: view,
      margin: EdgeInsets.all(2),
    );
    final editView = AgileCardEditView(card, _updateData);
    final gesture = GestureDetector(
      child: container,
      onTap: () {
        _setFocus(card);
      },
      onLongPress: () {
        final cardEditRoute = MaterialPageRoute(builder: (context) => editView);
        Navigator.push(context, cardEditRoute);
      },
    );
    return gesture;
  }

  Widget _getViewForNewCard () {
    final container = Container(
        child: NewAgileCardButton(),
      margin: EdgeInsets.all(2),
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