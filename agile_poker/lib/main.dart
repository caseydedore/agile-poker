import 'package:flutter/material.dart';
import 'deck.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agile Poker',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Deck(title: 'Agile Deck'),
    );
  }
}
