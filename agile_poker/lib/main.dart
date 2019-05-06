import 'package:flutter/material.dart';
import 'deck-view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agile Poker',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DeckView(title: 'Agile Deck'),
    );
  }
}
