import 'package:flutter/material.dart';
import 'agile_card_view.dart';
import 'focus_view.dart';
import 'package:agile_poker/data/agile_card_data.dart';
import 'package:agile_poker/agile_card_edit_view.dart';

class Deck extends StatefulWidget {
  Deck({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  List<Widget> _cards;

  @override
  void initState() {
    _updateData();
    super.initState();
  }

  void _updateData() {
    _getCards().then((widgets) {
      setState(() {
        _cards = widgets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Scrollbar(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _cards ?? [],
      )
    ));
  }

  Future<List<Widget>> _getCards() async {
    final data = AgileCardData();
    final cards = await data.getAgileCards();
    final cardWidgets = cards.map((card) {
      final view = AgileCardView.as(card);
      final container = Center(
          child: view
      );
      final editView = AgileCardEditView(card, _updateData);
      final gesture = GestureDetector(
        child: container,
        onTap: () {
          final cardViewRoute = MaterialPageRoute(
              builder: (context) => FocusView(view));
          Navigator.push(context, cardViewRoute);
        },
        onDoubleTap: () {
          final cardEditRoute = MaterialPageRoute(
            builder: (context) => editView);
          Navigator.push(context, cardEditRoute);
        },
      );
      return gesture;
    }).toList();
    return cardWidgets;
  }
}