import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'deck_view.dart';
import 'deck_root.dart';
import 'dialog/card_edit_dialog_builder.dart';

class DeckMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: DeckView(),
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
        DeckRoot.of(context).sortCards(option);
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
        DeckRoot.of(context).addNewCard();
      },
    );

  void _showEditDialog(BuildContext context) {
    final deckInterface = DeckRoot.of(context);
    CardEditDialogBuilder.create(
        card: deckInterface.currentCard,
        minValue: 0,
        maxValue: 101,
    ).present(context);
  }
}