import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deck_main_view.dart';
import 'package:agile_poker/service/deck_provider.dart';
import 'package:agile_poker/service/current_card_provider.dart';

class DeckRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = DeckMainView();
    final cardDataProvider = ChangeNotifierProvider<DeckProvider>(
      builder: (_) => DeckProvider(),
      child: app,
    );
    final currentCardProvider = ChangeNotifierProvider<CurrentCardProvider>(
      builder: (_) => CurrentCardProvider(),
      child: cardDataProvider
    );
    return currentCardProvider;
  }
}