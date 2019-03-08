import 'package:flutter/material.dart';

class Deck extends StatefulWidget {
  Deck({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {

  final _card01 = 'https://allaboutcards.files.wordpress.com/2009/07/queen-diamonds.png';
  final _card02 = 'https://allaboutcards.files.wordpress.com/2009/06/jack-spades.png';
  final _card03 = 'https://allaboutcards.files.wordpress.com/2009/07/bp-frogace.jpg?w=188&h=300';
  final _listWidth = 300.0;
  final _listMargin = EdgeInsets.all(20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: _listWidth,
              child: Image.network(_card01, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card02, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card03, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card02, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card01, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card03, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card01, fit: BoxFit.contain),
              margin: _listMargin
            ),
            Container(
              width: _listWidth,
              child: Image.network(_card02, fit: BoxFit.contain),
              margin: _listMargin
            ),
          ],
        )
      ),
    );
  }
}