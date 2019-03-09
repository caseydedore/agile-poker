import 'package:flutter/material.dart';
import 'agile_card.dart';

class Deck extends StatefulWidget {
  Deck({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _getCards(100),
        )
      ),
    );
  }

  List<Widget> _getCards(int count){
    final _cards = List<Widget>();
    for(var i = 0; i < count; i++){
      _cards.add(AgileCard.asBlank());
    }
    return _cards;
  }
}