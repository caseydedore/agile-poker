import 'package:flutter/material.dart';
import 'agile_card_view.dart';
import 'focus_view.dart';
import 'package:agile_poker/data/agile_card_data.dart';

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
    _getCards().then((widgets) {
      setState(() {
        _cards = widgets;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Scrollbar(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _cards ?? [],
          )
        )
      ),
    );
  }

  Future<List<Widget>> _getCards() async {
    final data = AgileCardData();
    final cards = await data.getAgileCards();
    final cardWidgets = cards.map((card) {
      var view = AgileCardView.as(card);
      var container = Center(
          child: view
      );
      var gesture = GestureDetector(
        child: container,
        onTap: () {
          final cardViewRoute = MaterialPageRoute(
              builder: (context) => FocusView(view));
          Navigator.push(context, cardViewRoute);
        },
      );
      return gesture;
    }).toList();
    return cardWidgets;
  }
}