import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'deck_view.dart';
import 'deck_root.dart';
import 'dialog/card_edit_dialog_builder.dart';
import 'dialog/card_delete_dialog_builder.dart';

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
      _cardModificationMenu(context),
      _appTitle(),
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

  Widget _cardModificationMenu(BuildContext context) =>
    PopupMenuButton<_EditOption>(
      icon: Icon(Icons.edit),
      tooltip: 'Edit',
      onSelected: (option) {
        if (option == _EditOption.edit) _showEditDialog(context);
        else _showDeleteDialog(context);
      },
      itemBuilder: (context) => <PopupMenuEntry<_EditOption>>[
        const PopupMenuItem(
          value: _EditOption.edit,
          child: Text('Edit Card'),
        ),
        const PopupMenuItem(
          value: _EditOption.delete,
          child: Text('Delete Card')
        ),
      ],
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

  void _showDeleteDialog(BuildContext context) {
    final deckInterface = DeckRoot.of(context);
    CardDeleteDialogBuilder.create(
        card: deckInterface.currentCard,
    ).present(context);
  }
}

enum _EditOption { edit, delete }