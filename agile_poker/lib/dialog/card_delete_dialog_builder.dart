import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agile_poker/service/deck_provider.dart';
import '../data/model/agile_card.dart';
import '../service/image_storage.dart';

class CardDeleteDialogBuilder {
  final AgileCard _card;
  final Function _onDelete;

  CardDeleteDialogBuilder(this._card, this._onDelete);

  factory CardDeleteDialogBuilder.create({@required AgileCard card, Function onDelete}) =>
      CardDeleteDialogBuilder(card, onDelete ?? {});

  void present(BuildContext context) async {
    await showDialog(
      context: context,
      builder: _build
    );
  }

  Widget _build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Card'),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: Navigator.of(context).pop
        ),
        FlatButton(
          child: Text('Ok'),
          onPressed: () { _deleteCard(context); } ,
        )
      ],
    );
  }

  void _deleteCard(BuildContext context) async {
    await ImageStorage().deleteImage(_card.image);
    await Provider.of<DeckProvider>(context).removeCard(_card);
    _onDelete();
    Navigator.of(context).pop();
  }
}