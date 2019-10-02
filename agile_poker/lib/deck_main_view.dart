import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agile_poker/service/deck_provider.dart';
import 'package:agile_poker/service/current_card_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'deck_view.dart';
import 'dialog/card_edit_dialog_builder.dart';
import 'package:agile_poker/loading_view.dart';
import 'package:agile_poker/data/model/agile_card.dart';

class DeckMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: LoadingView<List<AgileCard>>(
        viewBuilder: (List<AgileCard> cards) => DeckView(cards: cards),
        loadingOperation: Provider.of<DeckProvider>(context).get()
      )
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    actions: <Widget>[
      _cardSortMenu(context),
      _appTitle(),
      _editCardButton(context),
      _newCardButton(context),
    ],
  );

  Widget _appTitle() =>
    Expanded(
      child: Center(
        child: AutoSizeText(
          'Agile Poker Deck',
          minFontSize: 12,
          style: TextStyle(fontSize: 20),
        )
      ),
    );

  Widget _cardSortMenu(BuildContext context) =>
    PopupMenuButton<CardSortMode>(
      icon: Icon(Icons.sort),
      tooltip: 'Sort Deck',
      onSelected: (option) {
        Provider.of<DeckProvider>(context).sortCards(option);
      },
      itemBuilder: (context) => <PopupMenuEntry<CardSortMode>>[
        const PopupMenuItem(
          value: CardSortMode.asc,
          child: Text('Ascending'),
        ),
        const PopupMenuItem(
          value: CardSortMode.desc,
          child: Text('Descending')
        ),
      ],
    );

  Widget _editCardButton(BuildContext context) =>
    IconButton(
      icon: Icon(Icons.edit),
      tooltip: 'Edit Card',
      onPressed: () {
        _showEditDialog(context);
      },
    );

  Widget _newCardButton(BuildContext context) =>
    IconButton(
      icon: Icon(Icons.add_box),
      tooltip: 'Create New Card',
      onPressed: () {
        Provider.of<DeckProvider>(context).addNewCard();
      },
    );

  void _showEditDialog(BuildContext context) {
    final cardProvider = Provider.of<CurrentCardProvider>(context);
    CardEditDialogBuilder.create(
      card: cardProvider.currentCard,
      minValue: 0,
      maxValue: 101,
    ).present(context);
  }
}